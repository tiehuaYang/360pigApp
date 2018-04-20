<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="/manage/include/header.jsp"%>
    <!--LOADING STYLESHEET FOR PAGE-->
<style>
.Product {
	-moz-column-count:6; /* Firefox */
	-webkit-column-count:6; /* Safari and Chrome */
	column-count:6;
	
	/* -moz-column-gap:10px; 
	-webkit-column-gap:10px;
	column-gap:10px; */
}
.Product ul li,.consumption ul li {
    padding-top:20px;
    list-style:none;
}
.dot {
    width:6px;
    height:6px;
    background-color:#52c8f4;
    border-radius:3px;
    margin-left:-12px;
}
.consumption {
    -moz-column-count:4; /* Firefox */
	-webkit-column-count:4; /* Safari and Chrome */
	column-count:4;
}
.product-ul,
.farmInventory-ul{
	list-style: none;
    background: #fff;
    width: 49%;
    overflow: hidden;
    padding: 20px 0 20px 65px;
    position: relative;
    min-height: 200px;
}
.product-li,
.farmInventory-li {
    float: left;
    width: 16.6%;
    padding-top: 20px;
}
span.product-num,
span.farmInventory-num {
    font-size: 18px;
    font-weight: bold;
}
.farmInventory-ul{
	position: absolute;
	right:0;
	top:0;
	bottom:0;
	margin:0;
}
@media screen and (min-width:1920px) {
    #sm7 {
        width:60% !important;
    }
    #sm4 {
        width:39% !important;
        margin-left:15px !important;
    }
}
</style>
</head>

<body class = "${theme }" >
  <div>
    <!--BEGIN BACK TO TOP-->
      <a id="totop" href="#"><i class="fa fa-angle-up"></i></a>
    <!--END BACK TO TOP-->
    <!--BEGIN TOPBAR-->
      <%@ include file="/manage/include/banner.jsp"%>
    <!--END TOPBAR-->
  <div id="wrapper">
    <!--BEGIN SIDEBAR MENU-->
      <%@ include file="/manage/include/menu.jsp"%>
    <!--END SIDEBAR MENU-->
    <!--BEGIN PAGE WRAPPER-->
            <div id="page-wrapper">
                <!--BEGIN TITLE & BREADCRUMB PAGE-->
                <div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
                    <div class="page-header pull-left">
                        <div class="page-title">控制面板</div>
                    </div>
                    <ol class="breadcrumb page-breadcrumb pull-left">
                        <li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li class="hidden"><a href="#">控制面板</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li class="active">控制面板</li>
                    </ol>
                    <div class="clearfix"></div>
                </div>
                <!--END TITLE & BREADCRUMB PAGE-->
                <!--BEGIN CONTENT-->
                <div class="page-content">
                    <div id="tab-general">
                    	<div id="sum_box" class="row mbl">
		                    <c:choose>
			                	<c:when test="${sessionScope.USERVO.level == enterpriseLevel}">
			                        	<div class="col-sm-6 col-md-3">
			                                <div class="panel visit db mbm" onclick="window.location.href='${contextPath}/manage/showStuff'">
			                                    <div class="panel-body">
			                                        <p class="icon"><i class="icon fa fa-group"></i>
			                                        </p>
			                                        <h4 class="value"><span>${obj.userCount}</span></h4>
			                                        <p class="description">企业人数</p>
			                                    </div>
			                                </div>
			                            </div>
<%-- 			                            <div class="col-sm-6 col-md-3">
			                                <div class="panel profit db mbm" onclick="window.location.href='${contextPath}/manage/showTask'">
			                                    <div class="panel-body">
			                                        <p class="icon"><i class="icon fa fa-tasks"></i>
			                                        </p>
			                                        <h4 class="value"><span>${obj.taskCount}</span></h4>
			                                        <p class="description">在途任务总数</p>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="col-sm-6 col-md-3">
			                                <div class="panel income db mbm" onclick="window.location.href='${contextPath}/manage/showTaskHis'">
			                                    <div class="panel-body">
			                                        <p class="icon"><i class="icon fa fa-check"></i>
			                                        </p>
			                                        <h4 class="value"><span>${obj.hisTaskCount}</span></h4>
			                                        <p class="description">已完成任务</p>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="col-sm-6 col-md-3">
			                                <div class="panel task db mbm" onclick="window.location.href='${contextPath}/manage/showMsgList'">
			                                    <div class="panel-body">
			                                        <p class="icon"><i class="icon fa fa-exclamation-triangle"></i>
			                                        </p>
			                                        <h4 class="value"><span>${obj.msgCount}</span></h4>
			                                        <p class="description">最新告警</p>
			                                    </div>
			                                </div>
			                            </div> --%>
			                        
			                        </c:when>
		                        </c:choose>
                        </div>
                   </div>
<%--                    <div id="main2" style="height:350px;width:100%;"></div> <!-- 报表 -->
				   <br />
				   <div style="position: relative;box-sizing:border-box;">
					   <ul class="product-ul">
					   		<h6 style="color:#333;position: absolute;top: 0;left: 0;width: 100%;padding-left: 10px;"><strong>产物产量</strong></h6>
					   	   <c:forEach var="productVO" items="${obj.productList}" varStatus="status">
						   <li class="product-li">
						   		<div class="dot"></div>
						   		<p style="margin-top:-12px;margin-bottom: 0;">${productVO.productName}</p>
						   		<span class="product-num">${productVO.reportAmount}</span>
						   		<span class="product-unit">${productVO.productUnit}</span>
		                   </li>
		                   </c:forEach>
					   </ul>
					   <ul class="farmInventory-ul">
					   		<h6 style="color:#333;position: absolute;top: 0;left: 0;width: 100%;padding-left: 10px;"><strong>耗料量</strong></h6>
				           	<c:forEach var="farmInventoryLogVO" items="${obj.farmInventoryLogList}" varStatus="status">
			            	<li class="farmInventory-li">
				            	<div class="dot"></div>
				            	<p style="margin-top:-12px;margin-bottom: 0;">${farmInventoryLogVO.materialName}</p>
				            	<span class="farmInventory-num">${farmInventoryLogVO.count}</span>
				            	<span class="farmInventory-unit">${farmInventoryLogVO.unitName}</span>
			                </li>
				           	</c:forEach>
                       </ul>
				   </div>   --%>           
             </div>
    <!--END CONTENT-->
    
    </div>
    <!--BEGIN FOOTER-->
      <%@ include file="include/footer.jsp"%>
    <!--END FOOTER-->
    <!--END PAGE WRAPPER-->
    
    <!--CORE JAVASCRIPT-->
    <script src="js/main.js"></script>
    <!--LOADING SCRIPTS FOR PAGE-->
    <script src="js/index.js"></script>
    
    <script type="text/javascript">
    	$("#indexMenu").addClass('active');
	</script>
<script src="${contextPath}/manage/js/echarts-all.js"></script>

<script type="text/javascript">

// //基于准备好的dom，初始化echarts图表
// var myChart = echarts.init(document.getElementById('main2')); 

// /* var myChartContainer = function () {
//     myChart.style.width = window.innerWidth+'px';
//     myChart.style.height = window.innerHeight+'px';
// };
// myChartContainer();
// var myChart = echarts.init(myChart); */

// var dateStr = new Array();
// var date = new Date();
// date.setDate(date.getDate() - 15);
// for(var i = 0 ; i < 15 ; i++){
// 	date.setDate(date.getDate() + 1);
// 	dateStr.push((date.getMonth()+1) + "月" + date.getDate() + "日");
// };

// option = {
// 		backgroundColor:'#fff',
// 	    title : {
// 	        text: '死淘量',
// 	        link:'',
// 	        subtext: '单位(只)' 
// 	    },
// 	    tooltip : {
// 	        trigger: 'axis',
//         	axisPointer : {            // 坐标轴指示器，坐标轴触发有效
//             type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
//             } 
// 	    },
// 	    legend: {
// 	        data:['','死淘量','']    
// 	    },
// 	    /* toolbox: {
// 	        show : true,
// 	        feature : {
// 	            mark : {show: true},
// 	            dataView : {show: true, readOnly: false},
// 	            magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
// 	            restore : {show: true},
// 	            saveAsImage : {show: true}
// 	        }
// 	    }, */
// 	    calculable : true,
// 	    xAxis : [
// 	        {
// 	        	splitLine:{show: false},//去除网格线
	        	
// 	            type : 'category',
// 	            boundaryGap : false,
// 	            data : dateStr
// 	        }
// 	    ],
// 	    yAxis : [
// 	        {
// 	            type : 'value'
// 	        }
// 	    ],
// 	    series : [
// 	        /* {
// 	            name:'成交',
// 	            type:'line',
// 	            smooth:true,
// 	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
// 	            data:[10, 12, 21, 54, 260, 830, 710]
// 	        }, */
// 	        { 
	        	
// 	            name:'死淘量',
// 	            type:'line',
// 	            smooth:true,
// 	            itemStyle: {normal:{color:'#52c8f4',areaStyle: {color:'#52c8f4',type: 'default'}}},
// 	            data:[
// 	            	<c:forEach var="deadCount" items="${obj.deadCount}" varStatus="status">
// 	        			"${deadCount}"
// 	        			<c:if test="${!status.last}">,</c:if>
//         			</c:forEach>
//             	]
// 	        }
// 	        /* {
// 	            name:'意向',
// 	            type:'line',
// 	            smooth:true,
// 	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
// 	            data:[1320, 1132, 601, 234, 120, 90, 20]
// 	        } */
// 	    ]
	   
// 	};
	                    
// // 为echarts对象加载数据 
// myChart.setOption(option); 

// window.onresize = function () {
//     myChartContainer();
//     myChart.resize();
// };
</script>

</body>

</html>