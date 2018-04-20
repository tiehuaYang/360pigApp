<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
 <!--LOADING STYLESHEET FOR PAGE-->
<link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css">
<script src="${contextPath}/manage/js/echarts-all.js"></script>
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
                        <li><i class="fa fa-home"></i>&nbsp;<a href="${contextPath}/manage/showIndex">首页</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li><a href="#">统计报表</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li class="active">死淘量统计</li>
                    </ol>
                    <div class="clearfix"></div>
                </div>
                <!--END TITLE & BREADCRUMB PAGE-->
                
                <div id="exportForm" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" data-dismiss="modal" aria-hidden="true"
									class="close">&times;</button>
								<h4 class="modal-title">选择导出数据的条件</h4>
							</div>
							<form id="exportedForm" class="form-horizontal" method="POST">
								<div class="modal-body">
									<div class="form">
										<div class="form-group">
											<label for="exportStartDate" class="control-label col-md-3">起始日期</label>
											<div class="col-md-7">
												<input type="text" id="exportStartDate" name="exportStartDate" autocomplete="off" placeholder="请选择时间" class="form-control" />
											</div>
										</div>
										<div class="form-group">
											<label for="exportEndDate" class="control-label col-md-3">终止日期</label>
											<div class="col-md-7">
												<input type="text" id="exportEndDate" name="exportEndDate" autocomplete="off" placeholder="请选择时间" class="form-control" />
											</div>
										</div>
										<div class="form-group">
											<label for="exportSalesId" class="control-label col-md-3">客户选择</label>
											<div class="col-md-7">
												<select id="exportSalesId" class="form-control" name="exportSalesId">
							                         <option value=""></option>
							                         <c:forEach var="joinInVO" items="${obj.joinInList}" varStatus="status">
                                                         <option value="${joinInVO.salesVO.companyId}" >${joinInVO.salesVO.companyName}</option>
                                                     </c:forEach>
                                                 </select>
											</div>
										</div>
										<div class="form-group">
											<label for="exportSort" class="control-label col-md-3">时间先后排序</label>
											<div class="col-md-7">
												<select id="exportSort" name="exportSort" class="form-control" >
													 <option value="2">降序</option>
													 <option value="1">升序</option>
												 </select>
											</div>
										</div>
										<br />
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" data-dismiss="modal" class="btn btn-info" onclick="orderDownload()">确认并导出Excel</button>
									<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
								</div>
							</form>
						</div>
					</div>
				</div>
            
                <!--BEGIN CONTENT-->
                <div class="page-content">
                    <div id="table-advanced" class="row">
                        <div class="col-lg-12">
                            <div id="tableadvancedTabContent" class="tab-content">
                                <div id="table-sorter-tab" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-lg-12">
                                        	<div class="row">
                                        		<div class="col-md-3" style="margin-top:5px;">
                                            		<h5>
                                            			<a href="${contextPath}/manage/showDeathSum?dateType=1" <c:if test="${obj.dateType == '1' }">class="text-primary"</c:if>>&nbsp;&nbsp;本月&nbsp;&nbsp;</a>
                                            			<a href="${contextPath}/manage/showDeathSum?dateType=2" <c:if test="${obj.dateType == '2' }">class="text-primary"</c:if>>&nbsp;&nbsp;上月&nbsp;&nbsp;</a>
                                            			<a href="${contextPath}/manage/showDeathSum?dateType=3" <c:if test="${obj.dateType == '3' }">class="text-primary"</c:if>>&nbsp;&nbsp;本周&nbsp;&nbsp;</a> 
                                            			<a href="${contextPath}/manage/showDeathSum?dateType=4" <c:if test="${obj.dateType == '4' }">class="text-primary"</c:if>>&nbsp;&nbsp;上周&nbsp;&nbsp;</a> 
                                            		</h5>
                                                 </div>
                                                 <div style="font-size:14px;" class="col-md-8" style="margin-top:10px;">
                                                 	时段选择：
                                                 <input id="dateType" name="dateType" type="hidden" value="${obj.dateType}" />
	                                             <input id="startDate" name="startDate" autocomplete="off" style="width:120px" type="text" class="form-control input-sm input-inline" placeholder="年-月-日" value="${obj.queryMap.startDate}"/>  到
	                                             <input id="endDate" name="endDate" autocomplete="off" style="width:120px" type="text" class="form-control input-sm input-inline" placeholder="年-月-日" value="${obj.queryMap.endDate}" />&nbsp;&nbsp;
	                                             <%-- <select id="sort" class="form-control input-sm input-inline" name="sort" style="width:80px" value="${obj.queryMap.sort}">
							                         <option value="2" <c:if test="${obj.queryMap.sort == 'DESC'}">selected="selected"</c:if>>降序</option>
							                         <option value="1" <c:if test="${obj.queryMap.sort == 'ASC'}">selected="selected"</c:if>>升序</option>
                                                 </select> --%>
                                                 <button type="button" class="btn btn-info btn-xs" style="height: 30px; padding: 2px 12px;" onclick="querySum()">筛选</button>
                                                 <!-- <div class="btn-group">
												 <a href="#" class="btn btn-warning btn-xs dropdown-toggle" style="height: 30px; padding: 6px 12px;" onclick="showExport()" data-toggle="modal" data-target="#exportForm"> 
												 <i class="fa fa-wrench"></i>&nbsp;导出成Excel</a>
												 </div> -->
                                                 </div>
                                             </div>
                                    	</div>
                                </div>
                                <div class="clearfix"></div>
                               	<hr>
                               	<%-- <div class="row">
                                       <div class="col-lg-12">
                                           <table class="table table-hover table-striped table-bordered table-advanced ">
                                               <thead>
                                                   <tr>
                                                       <th  width="30%">订货单</th>
                                                       <th  width="10%" class="tc">订货客户数</th>
                                                       <th  width="10%"  class="tc">订货金额</th>
                                                       <th  width="10%" class="tc">实收金额</th>
                                                       <th width="10%" class="tc">待收金额</th>
                                                   </tr>
                                               </thead>
                                               <tbody id="storage_tbody">
                                                   <tr>
                                                       <td>
                                                       		共${obj.monthCount}笔
                                                        </td>
                                                       <td class="tc">
                                                       		${obj.customMonthCount}
                                                       </td>
                                                       <td  class="tc">
                                                           	￥ ${obj.monthAcount}
                                                   	</td>
                                                   	<td class="tc">
                                                           	￥ ${obj.actuallyFeeAcount}
                                                   	</td>
                                                   	<td class="tc">
                                                           	￥ ${obj.monthAcount - obj.actuallyFeeAcount}
                                                   	</td>
                                                   </tr>
                                               </tbody>
                                           </table>
                                       </div>
                                   </div> --%>
                                   <div class="clearfix"></div>
                                   <div id="deathEcharts" style="height:350px;width:100%;"></div> <!-- 报表 -->
                               	<div class="row">
                                       <div class="col-lg-12">
                                           <table class="table table-hover table-striped table-bordered table-advanced ">
                                               <thead>
                                                   <tr>
                                                   		<th width="16%" class="tc">任务单号</th>
                                                       <th  width="15%" class="tc">时间</th>
                                                       <th width="7%" class="tc">数量</th>
                                                       <th width="9%" class="tc">养殖场</th>
                                                       <th width="9%" class="tc">栋舍</th>
                                                   	   <th width="11%" class="tc">负责人</th>
                                                   	   <th class="tc">备注</th>
                                                   </tr>
                                               </thead>
                                               <tbody >
                                               		<c:forEach var="taskVO" items="${obj.deathList}" varStatus="status">
                                               			<c:if test="${taskVO.subTaskList.size() > 0}">
                                               			<tr>
                                               				<td rowspan="${taskVO.subTaskList.size()}" style="text-align:center; vertical-align:middle">
	                                                           <a href="#" onclick="showDetail('${taskVO.id}','${taskVO.finishPercent}')"  title="点击查看详情"><i class="fa fa-search"></i>&nbsp;${taskVO.batchNO} </a>
	                                                   		</td>
	                                                   		<c:forEach var="subTaskVO" items="${taskVO.subTaskList}" varStatus="status1">
	                                                   		<c:choose>
	                                                   			<c:when test="${status1.first}">
	                                                   				<td style="text-align:center; vertical-align:middle">
	                                                   					${subTaskVO.expectDateStr}
	                                                   				</td>
	                                                   				<td style="text-align:center; vertical-align:middle">
	                                                   					${subTaskVO.deadNum}
	                                                   				</td>
	                                                   				<td rowspan="${taskVO.subTaskList.size()}"  style="text-align:center;vertical-align:middle">
			                                                       		${taskVO.farmName}
			                                                       	</td>
			                                                       	<td rowspan="${taskVO.subTaskList.size()}"  style="text-align:center;vertical-align:middle">
			                                                       		${taskVO.penName}
			                                                        </td>
			                                                        <td rowspan="${taskVO.subTaskList.size()}"  style="text-align:center;vertical-align:middle">
			                                                        </td>
			                                                        <td style="text-align:center; vertical-align:middle">
			                                                        	${subTaskVO.deadReason}
	                                                   				</td>
	                                                   			</c:when>
	                                                   			<c:otherwise>
	                                                   				<tr>
			                                                   			<td style="text-align:center; vertical-align:middle">
		                                                   					${subTaskVO.expectDateStr}
		                                                   				</td>
		                                                   				<td style="text-align:center; vertical-align:middle">
		                                                   					${subTaskVO.deadNum}
		                                                   				</td>
		                                                   				<td style="text-align:center; vertical-align:middle">
		                                                   					${subTaskVO.deadReason}
		                                                   				</td>
			                                                   		</tr>
	                                                   			</c:otherwise>
	                                                   		</c:choose>
	                                                   		</c:forEach>
	                                                   	</tr>
	                                                   	</c:if>
	                                                   	
	                                                   	<c:if test="${taskVO.subTaskHisList.size() > 0}">
                                               			<tr>
                                               				<td rowspan="${taskVO.subTaskHisList.size()}" style="text-align:center; vertical-align:middle">
	                                                           ${taskVO.batchNO}
	                                                           <%-- <a href="#"  onclick="showOrderDetail('${orderVO.orderId}');" <c:if test="${obj.dateType == '4' }"> class="text-primary" </c:if>>&nbsp;&nbsp;${orderVO.orderCode}&nbsp;&nbsp;</a> --%>
	                                                   		</td>
	                                                   		<c:forEach var="subTaskHisVO" items="${taskVO.subTaskHisList}" varStatus="status1">
	                                                   		<c:choose>
	                                                   			<c:when test="${status1.first}">
	                                                   				<td style="text-align:center; vertical-align:middle">
	                                                   					${subTaskHisVO.expectDateStr}
	                                                   				</td>
	                                                   				<td style="text-align:center; vertical-align:middle">
	                                                   					${subTaskHisVO.deadNum}
	                                                   				</td>
	                                                   				<td rowspan="${taskVO.subTaskHisList.size()}"  style="text-align:center;vertical-align:middle">
			                                                       		${taskVO.farmName}
			                                                       	</td>
			                                                       	<td rowspan="${taskVO.subTaskHisList.size()}"  style="text-align:center;vertical-align:middle">
			                                                       		${taskVO.penName}
			                                                        </td>
			                                                        <td rowspan="${taskVO.subTaskHisList.size()}"  style="text-align:center;vertical-align:middle">
			                                                        </td>
			                                                        <td style="text-align:center; vertical-align:middle">
			                                                        	${subTaskHisVO.deadReason}
	                                                   				</td>
	                                                   			</c:when>
	                                                   			<c:otherwise>
	                                                   				<tr>
			                                                   			<td style="text-align:center; vertical-align:middle">
		                                                   					${subTaskHisVO.expectDateStr}
		                                                   				</td>
		                                                   				<td style="text-align:center; vertical-align:middle">
		                                                   					${subTaskHisVO.deadNum}
		                                                   				</td>
		                                                   				<td style="text-align:center; vertical-align:middle">
		                                                   					${subTaskHisVO.deadReason}
		                                                   				</td>
			                                                   		</tr>
	                                                   			</c:otherwise>
	                                                   		</c:choose>
	                                                   		</c:forEach>
	                                                   	</tr>
	                                                   	</c:if>
		                                                </c:forEach>
                                               </tbody>
                                           </table>
                                       </div>
                                       <div class="col-lg-6">
	                                            	<div class="pagination-panel"> &nbsp;
	                                                	<a href="#" onclick="jumpPage('${obj.currentPage - 1}')"  class="btn btn-sm btn-success btn-prev gw-prev" <c:if test="${obj.currentPage == 1}">disabled </c:if>><i class="fa fa-angle-left"></i></a>&nbsp;
	                                                	<input id="currentPage" type="text" maxlenght="5"  value="${obj.currentPage}" class="pagination-panel-input form-control input-mini input-inline input-sm text-center gw-page" onchange="goPage('${obj.currentPage}','${obj.pageCount}')"/>&nbsp;
	                                                	<a href="#" onclick="jumpPage('${obj.currentPage + 1}')" class="btn btn-sm btn-success btn-prev gw-next" <c:if test="${obj.currentPage >= obj.pageCount}">disabled </c:if>>
	                                                	<i class="fa fa-angle-right"></i></a>&nbsp; 共有 ${obj.pageCount} 页 | 合计 ${obj.recordCount } 条记录
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
    <!--用于分页-->
    <script src="${contextPath}/manage/js/page/bootstrap-paginator.js"></script>
    <script src="${contextPath}/manage/js/page/jquery.pagination.js"></script>
    
    <!--日历控件-->
    <script type="text/javascript" src="${contextPath}/manage/js/calendarJs/jedate.js"></script>
    
    <script type="text/javascript">
    $(document).ready(function(){
    	activeMenu("taskSum","taskSumUL","deathList");
		
		var result = "${obj.result}";
	    var message = "${obj.msg}";
	    if(result=='OK'){
	    	toastr['success'](message, "");
	    }
	    else if(result=='FAIL'){
	    	toastr['error'](message, "");
	    }
        
    });
    
    	function querySum(){
    		var salesId = $("#salesId").val();
    		var startDate = $("#startDate").val();
    		var endDate = $("#endDate").val();
    		var sort = $("#sort").val();
    		window.location.href =  "${contextPath}/manage/showDeathSum?startDate=" + startDate +"&endDate=" + endDate + "&salesId=" + salesId + "&sort=" + sort;
    	}
    	
    	function jumpPage(currentPage){
    		var dataType = $("#dateType").val();
    		var salesId = $("#salesId").val();
    		var startDate = $("#startDate").val();
    		var endDate = $("#endDate").val();
    		var sort = $("#sort").val();
    		var pageSize = $("select[name=pageSize] option:selected" ).val();
    		window.location.href =  "${contextPath}/manage/showDeathSum?dateType="+dataType+"&startDate=" + startDate +
    				"&endDate=" + endDate + "&salesId=" + "&sort=" + sort + salesId+ "&currentPage="+currentPage +"&pageSize=" + pageSize;
    	}
        
    	function orderDownload(){
      		var salesId = $("#exportSalesId").val();
      		var startDate = $("#exportStartDate").val();
      		var endDate = $("#exportEndDate").val();
      		var sort = $("#exportSort").val();
    		var url = "${contextPath}/manage/exportOrderSum?startDate=" + startDate +
				"&endDate=" + endDate + "&salesId=" + salesId + "&sort=" + sort;
    		window.location.href = encodeURI(encodeURI(url));
    	}
    	
    	function showOrderDetail(id){
  			var url = "${contextPath}/manage/showSupplyOrderHisDetail?orderId="+id;      
  	    	window.location.href = url;
  		}
    	
    	function showExport(){
    		$("#exportStartDate").val($("#startDate").val());
    		$("#exportEndDate").val($("#endDate").val());
    		$("#exportSort").val($("#sort").val());
    		$("#exportSalesId").val($("#salesId").val());
    	}
    	
    	function showDetail(id,finishPercent){
        	var url = "${contextPath}/manage/showTaskDetail?type=manage&id="+id +"&finishPercent=" +finishPercent;
        	window.location.href = url;
        }
</script>

<script type="text/javascript">
    //jeDate.skin('gray');
	
    jeDate({
		dateCell:"#startDate",
		format:"YYYY-MM-DD",
		isinitVal:false,
		isTime:true, //isClear:false,
		//minDate:"2014-09-19 00:00:00",
		okfun:function(val){
				//alert(val);
		}
    })
    
    jeDate({
		dateCell:"#endDate",
		format:"YYYY-MM-DD",
		isinitVal:false,
		isTime:true, //isClear:false,
		//minDate:"2014-09-19 00:00:00",
		okfun:function(val){
				//alert(val);
		}
	})
	
	jeDate({
    		dateCell:"#exportStartDate",
    		format:"YYYY-MM-DD",
    		isinitVal:false,
    		isTime:true, 
    		okfun:function(val){
    				//alert(val);
    	}
    })
    
    jeDate({
    		dateCell:"#exportEndDate",
    		format:"YYYY-MM-DD",
    		isinitVal:false,
    		isTime:true, 
    		okfun:function(val){
    				//alert(val);
    	}
    })
</script>

<script src="${contextPath}/manage/js/echarts-all.js"></script>

<script type="text/javascript">

//基于准备好的dom，初始化echarts图表
var deathChart = echarts.init(document.getElementById('deathEcharts')); 


var dateStr = new Array();
var date = new Date("${obj.queryMap.endDate}");
date.setDate(date.getDate() - 15);
for(var i = 0 ; i < 15 ; i++){
	date.setDate(date.getDate() + 1);
	dateStr.push((date.getMonth()+1) + "月" + date.getDate() + "日");
};

option = {
		backgroundColor:'#fff',
	    title : {
	        text: '死淘量',
	        link:'',
	        subtext: '单位(只)' 
	    },
	    tooltip : {
	        trigger: 'axis',
        	axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
            } 
	    },
	    legend: {
	        data:['','死淘量','']    
	    },
	    calculable : true,
	    xAxis : [
	        {
	        	splitLine:{show: false},//去除网格线
	        	
	            type : 'category',
	            boundaryGap : false,
	            data : dateStr
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value'
	        }
	    ],
	    series : [
	        { 
	        	
	            name:'死淘量',
	            type:'line',
	            smooth:true,
	            itemStyle: {normal:{color:'#52c8f4',areaStyle: {color:'#52c8f4',type: 'default'}}},
	            data:[
	            	<c:forEach var="deadCount" items="${obj.deadCount}" varStatus="status">
	        			"${deadCount}"
	        			<c:if test="${!status.last}">,</c:if>
        			</c:forEach>
            	]
	        }
	    ]
	   
	};
	                    
// 为echarts对象加载数据 
deathChart.setOption(option); 

window.onresize = function () {
    myChartContainer();
    deathChart.resize();
};
</script>
</body>

</html>