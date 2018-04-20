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
   
<style>
#table-sticky-tab p{
	height:17px;
}
</style>
   
<body onload="checkDead();" class=" ${theme }">
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
                                <li class="active"><a href="#table-sticky-tab" data-toggle="tab">养殖任务</a></li>
                            </ul>
                            <div id="tableadvancedTabContent" class="tab-content">
                                <div id="table-sticky-tab" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-lg-12">
                                        <div class="row">
                                                <div class="col-md-4 blog-img">
                                                	<img src="${QUPLOADIMG}${obj.taskVO.picUrl}" alt="" class="img-responsive" style="margin:0 auto;max-width: 50%;"/>
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
	                                                            
	                                                            <p class="">${obj.taskVO.startDayStr}</p>
	                                                         </div>
	                                                     </div>
	                                                     <div class="form-group">
	                                                         <label class="col-md-3 control-label"><i class="fa fa-calendar fa-fw"></i>结束日期：</label>
	                                                         <div class="col-md-9">
	                                                         	<p class="">${obj.taskVO.endDayStr}</p>
	                                                         </div>
	                                                     </div>
	                                                     <div class="form-group">
	                                                         <label class="col-md-3 control-label"><i class="fa fa-exclamation-circle fa-fw" style="color: #d9534f;"></i>告警次数：</label>
	                                                         <div class="col-md-9">
	                                                         	<p class="">${obj.taskVO.errorCount}次</p>
	                                                         </div>
	                                                     </div>
	                                                     <div class="form-group">
	                                                         <label class="col-md-3 control-label"><i class="fa fa-signal fa-fw" style="color: #5cb85c;"></i>养殖数量：</label>
	                                                         <div class="col-md-9">
	                                                         	<p class="">目前${obj.taskVO.acturyAmount}只 &nbsp;(进苗数：${obj.taskVO.initAmount}只)</p>
	                                                         </div>
	                                                     </div>
                                                </div>
                                            </div>
                                        
                                            <form id="taskForm"  class="form-horizontal form-seperated" action="${contextPath}/manage/saveSubTask" method="POST" >
                                            <input name="id" type="hidden"  value="${obj.taskVO.id}"/>
                                            <input name="subTaskId" type="hidden"  value="${obj.subTaskVO.subTaskId}"/>
	                                            <div class="form-body">
		                                   		 <div class="clearfix"></div>
                                    			<hr>
                                    				<div class="form-group">
	                                    				<label class="col-md-3 control-label">死淘数量：</label>
	                                    				<div class="col-md-2">
		                                    				<input id="deadNum" name="deadNum" type="text" class="form-control"  onchange="checkDead();"
		                                    					<%-- <c:if test="${obj.subTaskVO.deadNum != 0}">value="${obj.subTaskVO.deadNum}"</c:if> --%> />
		                                    			</div>
		                                    			<label class="control-label" style="margin-left:-5px;margin-top:5px;">
			                                                    	只 
			                                                    	<!-- <span class="label label-info"  style="margin-left:8px;">Tips:</span>若出现死淘情况请务必填写本字段以及死淘原因以供分析 -->
			                                            </label>
		                                    		</div>
		                                    		<div id="deadReasonDiv" class="form-group hide">
	                                    				<label class="col-md-3 control-label">死淘原因：</label>
	                                    				<div class="col-md-4">
	                                    					<textarea name="deadReason" rows="6" placeholder="死淘原因" class="form-control">${obj.subTaskVO.deadReason}</textarea>
		                                    			</div>
		                                    		</div>
                                    				<c:forEach var="subTaskItemVO" items="${obj.subTaskVO.itemList}" varStatus="status">
			                                            <div class="form-group">
		                                                    <label class="col-md-3 control-label">${subTaskItemVO.operateVO.operateName}
		                                                    	<c:if test="${subTaskItemVO.operateVO.isRequired == 'Y'}"><span class='require'>*</span></c:if>：
		                                                    </label>
		                                                    <div class="col-md-2">
		                                                    	<input type="hidden" name="operateId" value="${subTaskItemVO.operateId}">
		                                                    	<input msgTitle="${subTaskItemVO.operateVO.operateName}" isRequire="${subTaskItemVO.operateVO.isRequired}" 
		                                                    	name="<%-- ${subTaskItemVO.subItemId} --%>operateVal" type="text" class="form-control validate" placeholder="已添加${subTaskItemVO.reportAmount}${subTaskItemVO.operateVO.spec}"/>
		                                                    </div>
		                                                    <label class="control-label" style="margin-left:-5px;margin-top:5px;">
		                                                    	${subTaskItemVO.operateVO.spec}
		                                                    </label>
		                                                </div>
	                                                </c:forEach>
	                                            
	                                                <%-- <div class="form-group">
	                                    				<label class="col-md-3 control-label">备注：</label>
	                                    				<div class="col-md-4">
	                                    					<textarea name="remark" rows="6" placeholder="备注" class="form-control">${obj.subTaskVO.remark}</textarea>
		                                    			</div>
		                                    		</div> --%>
		                                    		 <div class="row">
							                                        <div class="col-lg-11">
							                                            <table class="table table-hover table-striped table-bordered table-advanced tablesorter">
							                                                <thead>
							                                                    <tr>
							                                                        <th  width="10%">产物名称</th>
							                                                        <th  width="10%">单位</th>
							                                                        <th width="10%">产量</th>
							                                                        <th width="10%">备注</th>
							                                                    
							                                                    </tr>
							                                                </thead>
							                                               <c:forEach var="productionVO" items="${obj.productionlist}" varStatus="status">
							                                                <tbody id="storage_tbody">
							                                                    <tr id="tr1">
							                                                        <td>
							                                                        <input name="productId" type="hidden"  value="${productionVO.productId }" />
							                                                        <input name="productName" type="text" class="form-control" value="${productionVO.productName }" readonly/>
                                                                            		</td>
                                                                            		<td>
							                                                        	<input  name="productUnit"  type="text" class="form-control" value="${productionVO.productUnit }" readonly/>
							                                                        </td>
                                                                            		<td>
							                                                        <input name="productNums" type="text" class="form-control" />
                                                                            		</td>
							                                                        
							                                                        
							                                                        <td>
					                                                                    <input name="reMark" type="text"  class="form-control" />
							                                                    	</td>
							                                                    	
							                                                    </tr>
							                                                </tbody>
							                                               </c:forEach>
							                                            </table>
							                                            
							                                        </div>
							                                    </div>
	                                            </div>
                                            	<div class="form-actions text-right pal">
	                                                <button type="button" class="btn btn-primary" onclick="ev_validate()">保存</button>&nbsp;
	                                                <button type="button" class="btn btn-green" onclick="ev_back()">取消</button>
	                                            </div>
                                            </form>
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
    <script src="${contextPath}/manage/vendors/jquery-validate/jquery.validate.min.js"></script>
    
    <script type="text/javascript">
    //菜单初始化
   activeMenu("taskManage","taskUL","taskPendingMenu");
    var result = "${obj.result}";
    var message = "${obj.msg}";
    if(result=='OK'){
    	toastr['success'](message, "");
        setTimeout(function(){
        	window.location.href = "${contextPath}/manage/showPendingTaskList";
        },600);
    }
    else if(result=='FAIL'){
    	toastr['error'](message, "");
    }
        
   function ev_back(){
   	window.history.back();
   }
   
   /* function ev_validate(){
	   var isValid = true;
	   var amount = '${obj.taskVO.acturyAmount}';
	   var deadNum = $('#deadNum').val();
	   
	   //死淘数量不能大于该批次的养殖数量
	   if(isNaN(deadNum) || deadNum - amount > 0 ){
		   $('#deadNum').parent('div').removeClass("has-success").addClass("has-error");
  			isValid = false;
	   }
	   else{
		   $('#deadNum').parent('div').removeClass("has-error").addClass("has-success");
	   }
	   
	   $('.validate').each(function(){
		   	var isRequire = $(this).attr("isRequire");
		   	if(isRequire == 'Y'){
		   		if($(this).val().length <= 0){
		   			$(this).focus();
		   			$(this).parent('div').removeClass("has-success").addClass("has-error");
		   			isValid = false;
		   		}
		   		else{
		   			if($(this).val().length > 0 && isNaN($(this).val())){
		   				$(this).parent('div').removeClass("has-success").addClass("has-error");
			   			isValid = false;
		   			}
		   			else
		   				$(this).parent('div').removeClass("has-error").addClass("has-success");
		   		}	
		   	}
    	  });
	   if(isValid)
		   taskForm.submit();
   } */
   
   function ev_validate(){
	   var isValid = true;
	   var amount = '${obj.taskVO.acturyAmount}';
	   var deadNum = $('#deadNum').val();
	   
	   //死淘数量不能大于该批次的养殖数量
	   if(isNaN(deadNum) || deadNum - amount > 0 ){
		   $('#deadNum').parent('div').removeClass("has-success").addClass("has-error");
				isValid = false;
	   }
	   else{
		   $('#deadNum').parent('div').removeClass("has-error").addClass("has-success");
	   }
	   
	   $('.validate').each(function(){
		   	var isRequire = $(this).attr("isRequire");
		   	if(isRequire == 'Y'){
		   		if($(this).val().length <= 0){
		   			$(this).focus();
		   			$(this).parent('div').removeClass("has-success").addClass("has-error");
		   			isValid = false;
		   		}
		   		else{
		   			if($(this).val().length > 0 && isNaN($(this).val())){
		   				$(this).parent('div').removeClass("has-success").addClass("has-error");
			   			isValid = false;
		   			}
		   			else
		   				$(this).parent('div').removeClass("has-error").addClass("has-success");
		   		}	
		   	}
		  });
	   if(isValid){
	        $.ajax({
	            type: 'POST',
	            url: '${contextPath}/manage/saveSubTask',
	            data: $('#taskForm').serialize(),
	            async: false,
	            dataType: 'json',
	            success: function(result) {
	                if (result.result == 'OK') {
	                	toastr['success'](result.msg, "");
	                    setTimeout(function(){
	                    	window.location.href = "${contextPath}/manage/showPendingTaskList";
	                    },2000);
	                } else {
	                	toastr['error'](result.msg, "");
	                }
	            }
	        });
	   }
		//taskForm.submit();
	}
   
   
   function checkDead(){
	   var deadNum = $('#deadNum').val();
	   if(deadNum > 0){
		   $('#deadReasonDiv').removeClass("hide");
	   }
	   else{
		   $('#deadReasonDiv').addClass("hide");
	   }
		  
   }
   $(function(){
		   $("#addList").click(function(){
			   var ran = Math.floor(Math.random()*1000);
			   var  tr = "<tr id='tr" + ran + "'>"
            				+ "<td>"
        					+ "<input  name='productName'  type='text' class='form-control' />"
						+ "</td>"
						+ "<td>"
    					+ "<input  name='productNums'  type='text' class='form-control' />"
					+ "</td>"
        				+ "<td>"
        					+ "<input  name='productUnit'  type='text'  class='form-control' />"
        				+ "</td>"
        				
        				+ "<td>"
            				+ "<input name='reMark' type='text'  class='form-control' />"
    					+ "</td>"
    					+ "<td>"
    						+ "<button class='btn' onclick='del_tr("+ ran +")' class='col-md-3 control-label'><i class='fa fa-times'></i>&nbsp;&nbsp;删除</button>"
    					+ "</td>"
   				 + "</tr>";
			   $("#storage_tbody").append(tr);
		   });

	  
	}); 
 //删除规格
	function del_tr(n){
		$("#tr" + n).remove();
  	}
</script>
</body>

</html>