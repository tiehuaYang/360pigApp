<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
 <!--LOADING STYLESHEET FOR PAGE-->
<link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css">
<link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.1.1.min.css">
</head>
<style>
.quarantineCase-item{width:50%;float:left;position:relative;padding: 15px 10px;}
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
.fa-calendar {position:absolute;left:85%;top:38%}
#quarantineTime,#quarantineNum,#quarantineItems,#quarantineMode,#quarantineOfficer {width:70%;margin-left:25%;margin-top:-22px;} 
#immuneTime,#immuneNum,#immuneProject,#immuneMode,#immuneWorker,#vaccineDose,#vaccineName {width:70%;margin-left:25%;margin-top:-22px;} 
#negativeQuarantineNum {}

td .state-error + em,
.quarantineList td div.state-error {
display:inline-block;
}

/* #quarantineForm {position:relative;}
.state-error + em {position:absolute;left:15%;margin-top:-2%;} */
</style>

<body class = "${theme }" >
  <!--BEGIN MODAL CONFIG PORTLET-->
<div id="newUnit" class="modal fade" style="margin-top:3%;">
    <div class="modal-dialog">
	<form id="newUnitForm" class="form" method="post" action="">
	<input id="taskId" name="taskId" type="hidden" value=""/>
	<input id="acturyAmount" name="acturyAmount" type="hidden" value=""/>
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
					            <i class="fa fa-calendar"></i>
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
								class="form-control" style="height:25px;margin:auto;" placeholder="请选择检疫头数"/></div></td>
						</tr>
						<tr class="border1">
						<td class="border2">阳性</td>
						<td><div><input id="positiveQuarantineNum" name="positiveQuarantineNum" type="text"
								class="form-control" style="height:25px;margin:auto;" placeholder="请选择检疫头数"/></div></td>
						</tr>
						<tr class="border1">
						<td class="border2">疑似</td>
						<td><div><input id="suspectedQuarantineNum" name="suspectedQuarantineNum" type="text"
								class="form-control" style="height:25px;margin:auto;" placeholder="请选择检疫头数"/></div></td>
						</tr>
						<tr class="border1">
						<td class="border2">无效</td>
						<td><div><input id="invalidQuarantineNum" name="invalidQuarantineNum" type="text"
								class="form-control" style="height:25px;" placeholder="请选择检疫头数"/></div></td>
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
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" data-dismiss="modal" aria-hidden="true"
					class="close">&times;</button>
				<h4 class="modal-title" style="text-align:center;color:#000;font-size:16px;">免疫登记</h4>
			</div>
				<div class="modal-body">
					<div class="form">
						<br /> <br />
						<div class="quarantineCase">
							<div class="quarantineCase-item">
							<div class="caseLeft">
							<label for="immuneTime">免疫日期：</label>
							<i class="fa fa-calendar"></i>
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
						<div class="quarantineCase">
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
						<div class="quarantineCase">
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
						<div class="quarantineCase" style="width:100%;clear:both;margin-bottom:20px;">
							<div class="quarantineCase-item">
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
						<div class="form-group" style="margin-top:5px;margin-left:-22px;">
						    <label for="immuneRemark" class="control-label col-md-2" style="left:35px;color:#000;">备注：</label>
						    <textarea id="immuneRemark" name="immuneRemark" style="width:80%;height:70px;border:1px solid rgba(0,0,0,.1);"></textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer" style="border:none !important;margin-right:20px;margin-bottom:20px;">
					<button type="submit" class="btn btn-primary f5"
						style="width:70px;background-color:#52c8f4;border-color:#52c8f4;">保存</button>
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
                        <li class="active">养殖任务管理</li>
                    </ol>
                    <div class="clearfix"></div>
                </div>
                <!--END TITLE & BREADCRUMB PAGE-->
                <!--BEGIN CONTENT-->
                <div class="page-content">
                    <div id="table-advanced" class="row">
                        <div class="col-lg-12">
                            <ul id="tableadvancedTab" class="nav nav-tabs">
                                <li class="active"><a href="#table-sticky-tab" data-toggle="tab">任务列表</a></li>
                            </ul>
                            <div id="tableadvancedTabContent" class="tab-content">
                                <div id="table-sorter-tab" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="portlet box">
                                            <!--  查询条件表单    -->
	                                                <div class="col-lg-12">
		                                                <div class="portlet box">
							                                <!-- <div class="portlet-header">
							                                    <div class="caption">查询面板</div>
							                                    <div class="tools"><i class="fa fa-chevron-down"></i>
							                                    </div>
							                                </div> -->
							                                <%-- <div class="portlet-body" style="display: none;">
							                                    <form id="searchForm" action="${contextPath}/manage/showTask" class="horizontal-form" method="POST" >
							                                    <input id="pageSize" name="pageSize" type="hidden" class="form-control" value="${obj.pageSize}" />
							                                    <input id="currentPage" name="currentPage" type="hidden" class="form-control" value="${obj.currentPage}" />
				                                                        <div class="form-body pal">
				                                                            <div class="row">
				                                                                <div class="col-md-6">
				                                                                    <div class="form-group" style="margin-bottom:50px;">
				                                                                        <label for="batchNO" class="col-md-3 control-label" >任务批次号
				                                                                        </label>
				                                                                        <div class="col-md-8">
				                                                                            <input id="batchNO" name="batchNO" type="text" class="form-control" value="${obj.queryMap.batchNO}" />
				                                                                        </div>
				                                                                    </div>
				                                                                </div>
				                                                                <div class="col-md-6">
				                                                                    <div class="form-group" style="margin-bottom:50px;">
				                                                                        <label for="categoryId" class="col-md-3 control-label">品类
				                                                                        </label>
				                                                                        <div class="col-md-8">
				                                                                            <input id="categoryId" name="categoryId" type="hidden" class="form-control" value="${obj.queryMap.categoryId}"/>
	                                                        								<input id="categoryName" name="categoryName" onclick="ev_showCategory();return false;" type="text" placeholder="点击选择品类"  class="form-control" value="${obj.queryMap.categoryName}"/>
				                                                                        </div>
				                                                                    </div>
				                                                                </div>
				                                                                <div class="col-md-6">
				                                                                    <div class="form-group" style="margin-bottom:50px;">
				                                                                        <label for="userName" class="col-md-3 control-label">负责人员
				                                                                        </label>
				                                                                        <div class="col-md-8">
				                                                                            <input id="userId" name="userId" type="hidden" class="form-control" value="${obj.queryMap.userId}"/>
	                                                        								<input id="userName" name="userName" onclick="ev_showUser();return false;" type="text" placeholder="点击选择养户"  class="form-control" value="${obj.queryMap.userName}"/>
				                                                                        </div>
				                                                                    </div>
				                                                                </div>
				                                                                <div class="col-md-12">
				                                                                	<div class="col-md-9">
							                                                        </div>
				                                                                	<div class="col-md-3">
							                                                            <input id="search" type="button" class="btn btn-primary" value = "查询" onclick="ev_search()"/>&nbsp;
							                                                            <input type="button" class="btn btn-green" value = "清除查询条件" onclick="ev_cancel()"/>
							                                                        </div>
				                                                                </div>
				                                                            </div>
				                                                        </div>
				                                                 </form>
							                                </div> --%>
							                            </div>
			                                        </div>
			                                        <!--  查询条件表单   END -->
				                                <!-- <div class="portlet-header">
				                                <div class="row"> -->
	                                                    <%-- <div class="col-lg-6">
	                                                        <div class="pagination-panel">每次浏览&nbsp;
	                                                            <select name="pageSize" class="form-control input-xsmall input-sm input-inline" onchange="jumpPage('1')">
	                                                            	<option value="10" <c:if test="${obj.pageSize == '10' }">selected="selected"</c:if> >10</option>
	                                                                <option value="20" <c:if test="${obj.pageSize == '20' }">selected="selected"</c:if> >20</option>
	                                                                <option value="50"<c:if test="${obj.pageSize == '50' }">selected="selected"</c:if> >50</option>
	                                                                <option value="100"<c:if test="${obj.pageSize == '100' }">selected="selected"</c:if> >100</option>
	                                                            </select>&nbsp;记录 | 共有 ${obj.recordCount } 条记录
	                                                        </div>
	                                                    </div>
	                                                    <div class="actions"><a href="${contextPath}/manage/editTask" class="btn btn-info btn-xs"><i class="fa fa-plus"></i>&nbsp;新增养殖任务</a>&nbsp; --%>
				                                        <!-- 
				                                        <div class="btn-group"><a href="#" data-toggle="dropdown" class="btn btn-warning btn-xs dropdown-toggle"><i class="fa fa-wrench"></i>&nbsp;更多操作</a>
				                                            <ul class="dropdown-menu pull-right">
				                                                <li><a href="#">导出成Excel</a>
				                                                </li>
				                                                <li><a href="#">导出成CSV</a>
				                                                </li>
				                                                <li><a href="#">导出成XML</a>
				                                                </li>
				                                                <li class="divider"></li>
				                                                <li><a href="#">打印预览</a>
				                                                </li>
				                                            </ul>
				                                        </div>
				                                         -->
				                                   <!--  </div>
                                                	</div>
				                                </div> -->
				                                <div class="portlet-header">
													<div class="row">
														<div class="col-lg-12" style="margin-left:15px;">
															<form id="Phidden" action="${contextPath }/manage/showTask" method="post">
																<input id="pageSizes" name="pageSize" type="hidden" class="form-control" value="${obj.pageSize}" />
							                                    <input id="currentPages" name="currentPage" type="hidden" class="form-control" value="${obj.currentPage}" />
																<div class="pagination-panel"> 每次浏览&nbsp; 
																	<select name="pageSize" class="form-control input-xsmall input-sm input-inline" onchange="jumpPage('1')">
																		<option value="10" <c:if test="${obj.pageSize == '10' }">selected="selected"</c:if>>10</option>
																		<option value="20" <c:if test="${obj.pageSize == '20' }">selected="selected"</c:if>>20</option>
																		<option value="50" <c:if test="${obj.pageSize == '50' }">selected="selected"</c:if>>50</option>
																		<option value="100" <c:if test="${obj.pageSize == '100' }">selected="selected"</c:if>>100</option>
																	</select>&nbsp;记录 | 共有 ${obj.recordCount } 条记录&nbsp;&nbsp; 
																	
																	<input id="batchNO" name="batchNO" style="width: 120px" type="text" placeholder="任务批次号" class="form-control input-sm input-inline" value="${obj.queryMap.batchNO}" />
																	<input id="categoryId" name="categoryId" type="hidden" style="width: 120px" class="form-control input-sm input-inline" value="${obj.queryMap.categoryId}"/>
	                                                        		<input id="categoryName" name="categoryName" style="width: 120px" onclick="ev_showCategory();return false;" type="text" placeholder="点击选择品类"  class="form-control input-sm input-inline" value="${obj.queryMap.categoryName}"/>
	                                                        		<input id="penId" name="penId" type="hidden" style="width: 120px" class="form-control input-sm input-inline" value="${obj.queryMap.penId}"/>
	                                                        		<input id="penName" name="penName" style="width: 120px" onclick="ev_showPen();return false;" type="text" placeholder="点击选择栋舍"  class="form-control input-sm input-inline" value="${obj.queryMap.penName}"/>
																	
																	<%-- <input id="supplyerName" name="supplyerName" style="width: 120px" type="text"  placeholder="请输入批次号" 
																	    value="${obj.queryMap.supplyerName}" class="form-control input-sm input-inline" />&nbsp;&nbsp;
																	<input id="startDate" name="startDate" autocomplete="off" style="width: 120px" type="text" placeholder="点击选择养户"
																		value="${obj.queryMap.startDate}" class="form-control input-sm input-inline" />
																	<input  id="endDate" name="endDate"  autocomplete="off" style="width: 120px" type="text" placeholder="点击选择品类" 
																		value="${obj.queryMap.endDate}" class="form-control input-sm input-inline" />&nbsp; 
																	<input type="hidden" name="typehidden" value="P" />  --%>
																	<input type="button" class="btn btn-info btn-xs f4" style="height:30px;padding:2px 12px;" onclick="ev_search()" value="查询" autocomplete="off">
																	<input type="button"  class="btn btn-info btn-xs f4" style="height:30px;padding:2px 12px;" value = "清除查询条件" onclick="ev_cancel()"/>
																	<div class="actions"><a href="${contextPath}/manage/editTask" class="btn btn-info btn-xs" style="margin-top:2px;margin-right:25px;"><i class="fa fa-plus"></i>&nbsp;新增养殖任务</a>&nbsp;
																	<%-- <input type="button" class="btn btn-info btn-xs f4" style="height: 25px; padding: 2px 12px;color:#ffffff;background-color:#f58953;border-color:#f58953;float:right;" 
																		onclick="showSelect('${obj.currentPage}')" value="+ 新增养殖任务" /> --%>
																	<%-- <div class="actions"><a href="${contextPath}/manage/editCategory" class="btn btn-info btn-xs"><i class="fa fa-plus"></i>&nbsp;新增养殖任务</a>&nbsp; --%>
																</div>
															</form>
														</div>
														<!-- <div class="actions"> 
																	<i class="fa fa-plus"></i>&nbsp;新增采购单
																</a>&nbsp;
															<div class="btn-group">
																<a href="#" data-toggle="dropdown"
																	class="btn btn-warning btn-xs dropdown-toggle"><i
																	class="fa fa-wrench"></i>&nbsp;更多操作</a>
																<ul class="dropdown-menu pull-right">
																	<li><a href="#" data-toggle="modal" data-target="#exportForm" onclick="showExport()">导出成Excel</a></li>
																	</li>
																	<li><a href="#" onclick="newVersionAlert()">导出成XML</a>
																	</li>
																	<li class="divider"></li>
																	<li><a href="#" onclick="purchaseDownload()">打印预览</a>
																	</li>
																</ul>
															</div>
														</div> -->
													</div>
												</div>
												
												<hr class="divider"></hr>
				                                
                                            	<div class="portlet-body">
		                                            <table class="table table-hover table-striped table-bordered table-advanced tablesorter tb-sticky-header">
		                                                <thead class="success">
		                                                    <tr>
		                                                        <th width="3%">
		                                                            <input type="checkbox" class="checkall" />
		                                                        </th>
		                                                        <th width="13%"><i class="fa fa-search"></i>&nbsp;任务批次号</th>
		                                                        <th width="13%">品类</th>
		                                                        <th width="8%">负责栋舍</th>
		                                                        <th width="10%">开始时间</th>
		                                                        <th width="10%">结束时间</th>
		                                                        <th >目前进度</th>
		                                                        <th width="8%">告警次数</th>
		                                                        <th width="14%">操作</th>
		                                                    </tr>
		                                                </thead>
		                                                <tbody>
		                                                <c:forEach var="task" items="${obj.taskList}" varStatus="status">
		                                                	<tr>
		                                                        <td>
		                                                            <input type="checkbox" style="margin-top:70%;" />
		                                                        </td>
		                                                        <td>
		                                                        	<div style="margin:auto;margin-top:10%;text-decoration:underline !important"><a href="#" onclick="showDetail('${task.id}','${task.finishPercent}')"  title="点击查看详情"><i class="fa fa-search"></i>&nbsp;${task.batchNO} </a></div>
		                                                        </td>
		                                                        <td><div style="margin:auto;margin-top:10%;">${task.categoryName}</div></td>
		                                                        <td><div style="margin:auto;margin-top:20%;">${task.farmPenVO.penName}</div></td>
		                                                        <td><div style="margin:auto;margin-top:15%;"><fmt:formatDate value="${task.startDay}" pattern="yyyy-MM-dd"/></div></td>
		                                                        <td><div style="margin:auto;margin-top:15%;"><fmt:formatDate value="${task.endDay}" pattern="yyyy-MM-dd"/></div></td>
		                                                        <td>
					                                               <div id="center-text">
					                                                    <div class="progress" style="margin-top:20px;">
					                                                        <div role="progressbar" aria-valuetransitiongoal="${task.finishPercent}" class="progress-bar progress-bar-danger two-sec-ease-in-out"></div>
					                                                    </div>
					                                                </div>
		                                                        </td>
		                                                        <td><div style="margin:auto;margin-top:20%;">${task.errorCount}</div></td>
		                                                        <td class="oneway">
		                                                            <%-- <button type="button" class="btn btn-default btn-xs" onclick="filingTask('${task.id}','${task.finishPercent}')"><i class="fa fa-edit"></i>&nbsp; 归档</button>
		                                                            <button type="button" class="btn btn-danger btn-xs" onclick="delTask('${task.id}')"><i class="fa fa-trash-o"></i>&nbsp; 删除</button> --%>
		                                                            <div class="newadd" style="width: 86%;">
		                                                                <a href="#" data-toggle="modal" data-target="#newUnit" data-original-title="检疫登记" onclick="transmissionQuarantine('${task.id}','${task.acturyAmount}')">检疫登记</a>
		                                                                <a href="#" onclick="filingTask('${task.id}','${task.finishPercent}')">归档</a><br/>
		                                                                <a href="#" data-toggle="modal" data-target="#newImmune" data-original-title="免疫登记" onclick="transmissionImmune('${task.id}','${task.acturyAmount}')">免疫登记</a>
		                                                                <a class="deleteText" href="#">删除</a>
		                                                            </div>
		                                                        </td>
		                                                    </tr>
		                                                </c:forEach>
		                                                </tbody>
		                                            </table>
		                                          
		                                        </div>
		                                         <div class="col-lg-6" style="margin-left:-7px;">
													<div class="pagination-panel">
														&nbsp; <a href="#"
															onclick="jumpPage('${obj.currentPage - 1}')"
															class="btn btn-sm btn-success btn-prev gw-prev"
															<c:if test="${obj.currentPage == 1}">disabled </c:if>><i
															class="fa fa-angle-left"></i></a>&nbsp; <input
															id="currentPage" type="text" maxlenght="5"
															value="${obj.currentPage}"
															class="pagination-panel-input form-control input-mini input-inline input-sm text-center gw-page"
															onchange="goPage('${obj.currentPage}','${obj.pageCount}')" />&nbsp;
														<a href="#" onclick="jumpPage('${obj.currentPage + 1}')"
															class="btn btn-sm btn-success btn-prev gw-next"
															<c:if test="${obj.currentPage >= obj.pageCount}">disabled </c:if>>
															<i class="fa fa-angle-right"></i>
														</a>&nbsp; 共有 ${obj.pageCount} 页 | 合计 ${obj.recordCount } 条记录
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
              <%@ include file="../include/footer.jsp"%>
            <!--END FOOTER-->
            <!--END PAGE WRAPPER-->
            
    <!--LOADING SCRIPTS FOR PAGE-->
    <script src="${contextPath}/manage/vendors/jquery-tablesorter/jquery.tablesorter.js"></script>
    <script src="${contextPath}/manage/js/table-advanced.js"></script>
    <script src="${contextPath}/manage/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <script src="${contextPath}/manage/js/ui-progressbars.js"></script>
    <script src="${contextPath}/vendors/jquery-validate/jquery.validate.min.js"></script>
    <!--用于分页-->
    <script src="${contextPath}/manage/js/page/bootstrap-paginator.js"></script>
    <script src="${contextPath}/manage/js/page/jquery.pagination.js"></script>
    
    <!-- 日历控件 -->
    <script type="text/javascript"
			src="${contextPath}/js/calendarJs/jedate.js"></script>
    
    <script type="text/javascript">
    $(document).ready(function(){
		activeMenu("taskManage","taskUL","taskMenu");
		
        var result = "${obj.result}";
        var message = "${obj.msg}";
        if(result=='OK'){
        	toastr['success'](message, "");
        }
        else if(result=='FAIL'){
        	toastr['error'](message, "");
        }
        
    });
    
    function ev_showCategory(){
       	var url = "${contextPath}/manage/queryCategoryList";
    		if(navigator.userAgent.indexOf("Chrome") >0 ){
    			var winOption = "height=650px,width=1150px,top=10px,left=200px,resizable=yes,fullscreen=0, location=no";
    			var dialog = window.open(url,window, winOption);
    		}
    		else{
    			var args = "dialogWidth=1150px;dialogHeight=650px";
    			var dialog = window.showModalDialog(url,null,args);
    			$('#categoryId').val(dialog.categoryId);
    			$('#categoryName').val(dialog.categoryName);
    			
    		}
       }
       
       
       function ev_showUser(){
    	   	var url = "${contextPath}/manage/queryPeopleList";
    			if(navigator.userAgent.indexOf("Chrome") >0 ){
    				var winOption = "height=580px,width=900px,top=10px,left=100px,resizable=yes,fullscreen=0, location=no";
    				var dialog = window.open(url,window, winOption);
    			}
    			else{
    				var args = "dialogWidth=900px;dialogHeight=580px";
    				var returnVal = window.showModalDialog(url,null,args);
    				document.getElementById("userId").value = returnVal.userId;
    				document.getElementById("userName").value = returnVal.userName;
    			}
    	}
    
       function ev_showPen() {
           var url = "${contextPath}/manage/queryPenList";
           if (navigator.userAgent.indexOf("Chrome") > 0) {
               var winOption = "height=580px,width=900px,top=10px,left=100px,resizable=yes,fullscreen=0, location=no";
               var dialog = window.open(url, window, winOption);
           } else {
               var args = "dialogWidth=900px;dialogHeight=580px";
               var returnVal = window.showModalDialog(url, null, args);
               document.getElementById("penId").value = returnVal.penId;
               document.getElementById("penName").value = returnVal.penName;
           }
       }
        
        function filingTask(id,finishPercent){
        	var url = "${contextPath}/manage/showFilingTask?id="+id +"&finishPercent=" +finishPercent;
        	window.location.href = url;
        }
        
        function delTask(id){
        	if(window.confirm("确定要删除这条记录吗？")){
        	  var url = "${contextPath}/manage/delTask?id="+id;
        	    common_ajax(url,function(data){
        	    	toastr['success']("删除成功", "");
          	        setTimeout(function(){
          	        	search();
          	        },600);
    		  });
        	}
        }
        
        function showDetail(id,finishPercent){
        	var url = "${contextPath}/manage/showTaskDetail?type=manage&id="+id +"&finishPercent=" +finishPercent;
        	window.location.href = url;
        }
        
        var search = function(){
        	window.location.reload();
    	};
    	
    	
    	function jumpPage(currentPage){
     		var pageSize = $("select[name=pageSize] option:selected").val();
    		$("#pageSizes").val(pageSize);
    		$("#currentPages").val(currentPage);
    		Phidden.submit();
/* 			var pageSize = $( "select[name=pageSize] option:selected").val();
			var batchNO = $("#batchNO").val();
			var categoryId = $("#categoryId").val();
			var categoryName = $("#categoryName").val();
			var userId = $("#userId").val();
			var userName = $("#userName").val();
			var url = "${contextPath}/manage/showTask?currentPage=" + currentPage + "&pageSize=" + pageSize
					+ "&batchNO=" + batchNO + "&categoryId=" + categoryId + "&categoryName=" + categoryName + "&userId=" + userId + "&userName=" + userName;
			window.location.href = url; */
    	}
    	
    	function ev_search(){
     		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		$("#pageSizes").val(pageSize);
    		$("#currentPages").val(1);
    		Phidden.submit();
/*     		currentPage = "1";
			var pageSize = $( "select[name=pageSize] option:selected").val();
			var batchNO = $("#batchNO").val();
			var categoryId = $("#categoryId").val();
			var categoryName = $("#categoryName").val();
			var userId = $("#userId").val();
			var userName = $("#userName").val();
			var url = "${contextPath}/manage/showTask?currentPage=" + currentPage + "&pageSize=" + pageSize
					+ "&batchNO=" + batchNO + "&categoryId=" + categoryId + "&categoryName=" + categoryName + "&userId=" + userId + "&userName=" + userName;
			window.location.href = url; */
    	}
    	
    	function ev_cancel(){
    		$("#batchNO").val("");
    		$("#categoryId").val("");
    		$("#categoryName").val("");
    		$("#penId").val("");
    		$("#penName").val("");
    	}
    	
    	function ev_back(){
        	window.history.back();
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
	                  	        	search();
	                  	        },1000);
	                  	}
	                  	else if(data.result != null && data.result == 'FAIL'){
	                  		toastr['error'](data.msg, "");
	                  	}
                    }
                });
            }
        });
        
        function transmissionQuarantine(taskId,acturyAmount){
        	$("#taskId").val(taskId);
        	$("#acturyAmount").val(acturyAmount);
        }
        
        function transmissionImmune(taskId,acturyAmount){
        	$("#immuneTaskId").val(taskId);
        	$("#immuneActuryAmount").val(acturyAmount);
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
        	                  	        	search();
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

</script>
</body>

</html>