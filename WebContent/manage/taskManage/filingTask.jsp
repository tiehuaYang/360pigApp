<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
 <!--LOADING STYLESHEET FOR PAGE-->
<link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css">

<style>
#table-sticky-tab p{
	height:17px;
}
</style>

</head>

 <!--LOADING STYLESHEET FOR PAGE-->
 <link type="text/css" rel="stylesheet" href="vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.1.1.min.css">
 
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
                    <div class="page-header pull-left">
                        <div class="page-title">养殖任务管理</div>
                    </div>
                    <ol class="breadcrumb page-breadcrumb">
                        <li><i class="fa fa-home"></i>&nbsp;<a href="index.jsp">首页</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li><a href="#">养殖任务</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li class="active">养殖任务编辑</li>
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
                                                <div class="col-md-4">
                                                	<c:if test="${!empty obj.taskVO.picUrl}">
                                                		<img src="${contextPath}${obj.taskVO.picUrl}" alt="" class="img-responsive" />
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
	                                                     <c:if test="${!empty obj.taskVO.remark}">
	                                                     <div class="form-group">
	                                                         <label class="col-md-3 control-label"><i class="fa fa-comment-o fa-fw"></i>备注：</label>
	                                                         <div class="col-md-9">
	                                                         	<p class="">${obj.taskVO.remark}</p>
	                                                         </div>
	                                                     </div>
	                                                     </c:if>
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
                                            </div>
                                			<form id="filingForm"  class="form-horizontal form-seperated"  action="${contextPath}/manage/finishTask" method="POST" >
                                				<input name="id" type="hidden"  value="${obj.taskVO.id}"/>
	                                            <div class="form-body">
		                                   		 <div class="clearfix"></div>
                                    			<hr>
                                    				<div class="note note-info">
						                                <h4 class="box-heading">本批次养殖数据统计</h4>
						                                <p>以下数据仅供企业输入统计分析内部养殖数据使用</p>
						                            </div>
                                    				<div class="form-group">
	                                    				<label class="col-md-3 control-label">上市数量：</label>
	                                    				<div class="col-md-2">
		                                    				<input name="marketAmount" type="text" class="form-control"  />
		                                    			</div>
		                                    			<label class="control-label" style="margin-left:-5px;margin-top:5px;">
			                                                    	只 
			                                            </label>
		                                    		</div>
		                                    		<div class="form-group">
	                                    				<label class="col-md-3 control-label">上市重量：</label>
	                                    				<div class="col-md-2">
		                                    				<input name="marketWeight" type="text" class="form-control"  />
		                                    			</div>
		                                    			<label class="control-label" style="margin-left:-5px;margin-top:5px;">
			                                                    	公斤
			                                            </label>
		                                    		</div>
		                                    		<div class="form-group">
	                                    				<label class="col-md-3 control-label">领料重量：</label>
	                                    				<div class="col-md-2">
		                                    				<input name="feedWeight" type="text" class="form-control"  />
		                                    			</div>
		                                    			<label class="control-label" style="margin-left:-5px;margin-top:5px;">
			                                                    	公斤
			                                            </label>
		                                    		</div>
		                                            <div class="form-group">
	                                    				<label class="col-md-3 control-label">归档备注：</label>
	                                    				<div class="col-md-4">
	                                    					<textarea name="fillingRemark" rows="6" placeholder="归档备注" class="form-control"></textarea>
		                                    			</div>
		                                    		</div>
	                                            </div>
                                            	<div class="form-actions text-right pal">
	                                                <button type="submit" class="btn btn-primary">完成归档</button>&nbsp;
	                                                <button type="button" class="btn btn-green" onclick="ev_back()">取消</button>
	                                            </div>
                                            </form>
                                	
                                	
				            </div>
				          </div>
				        </div>
				      </div>
                <!--END CONTENT-->
            </div>
            <!--BEGIN FOOTER-->
              <%@ include file="../include/footer.jsp"%>
              <script src="${contextPath}/manage/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    		  <script src="${contextPath}/manage/js/ui-progressbars.js"></script>
    		  <script src="${contextPath}/manage/vendors/jquery-validate/jquery.validate.min.js"></script>
            <!--END FOOTER-->
            <!--END PAGE WRAPPER-->
            
    <!--LOADING SCRIPTS FOR PAGE-->
    <script type="text/javascript">
    //菜单初始化
    activeMenu("taskManage","taskUL","taskMenu");
    
    var result = "${obj.result}";
    var message = "${obj.msg}";
    if(result=='OK'){
    	toastr['success'](message, "");
        setTimeout(function(){
        	window.location.href = "${contextPath}/manage/showTask";
        },600);
    }
    else if(result=='FAIL'){
    	toastr['error'](message, "");
    }
    
   function ev_back(){
   	window.history.back();
   }
   
   
   $(function()
   		{
   		 var acturyAmount = '${obj.taskVO.acturyAmount}';
   		    // Validation
   		    $("#filingForm").validate(
   		        {
   		            // Rules for form validation
   		            rules:
   		            {
   		            	marketAmount:
   		                {
   		            		number: true,
   		            		maxlength:20,
   		            		max:acturyAmount
   		                },
   		            	 marketWeight:
   		                {
   		                    number: true,
   		                 	maxlength:20
   		                },
   		             feedWeight:
   		                {
   		                    number: true,
   		                    maxlength:20
   		                },
   		             fillingRemark:
   		                {
   		                 	maxlength:1000
   		                }
   		            },

   		            // Messages for form validation
   		            messages:
   		            {
   		            	marketAmount:
   		                {
   		            		number: '请输入正确的数字',
   		            		maxlength:'您输入的数字过大',
   		            		max:'不能超过目前存活数${obj.taskVO.acturyAmount}只'
   		                },
   		            	 marketWeight:
   		                {
   		            		number: '请输入正确的数字',
   		            		maxlength:'您输入的数字过大'
   		                },
   		             feedWeight:
   		                {
   		            		number: '请输入正确的数字',
		            		maxlength:'您输入的数字过大'
   		                },
   		             fillingRemark:
   		                {
		            		maxlength:'最大长度不能大于1000'
   		                }
   		            },

   		            // Do not change code below
   		            errorPlacement: function(error, element)
   		            {
   		                error.insertAfter(element.parent());
   		            }
   		        });
   		    
   	       
   		});

</script>
</body>

</html>