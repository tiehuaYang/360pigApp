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
.validateFormat em.invalid {
    padding-top:8px;
    clear:both;
    float:left;
}
</style>


</head>
   <!--LOADING STYLESHEET FOR PAGE-->
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
                                <li class="active"><a href="#table-sticky-tab" data-toggle="tab">养殖任务</a></li>
                            </ul>
                            <div id="tableadvancedTabContent" class="tab-content">
                                <div id="table-sticky-tab" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <form id="taskForm"  class="form-horizontal form-seperated" action="${contextPath}/manage/createTask" method="POST" >
                                            <input name="id" type="hidden"  value="${obj.taskVO.id}"/>
	                                            <div class="form-body">
	                                            	<div class="form-group">
	                                                    <label class="col-md-3 control-label">关联品类<span class='require'>*</span></label>
	                                                    <div class="validateFormat col-md-4" >
	                                                    <div class="col-md-12 input-icon " style="padding:0;"><i class="fa fa-hand-o-right"></i>
	                                                    	<input id="categoryId" name="categoryId" type="hidden" class="form-control" value="${obj.taskVO.categoryId}"/>
	                                                        <input id="categoryName" name="categoryName" onclick="ev_showCategory();return false;" type="text" placeholder="点击选择品类"  class="form-control" value="${obj.taskVO.categoryName}"/>
	                                                    </div>
	                                                    </div>
	                                                </div>
	                                                <div class="form-group">
	                                                    <label for="breedDaysTotal" class="col-md-3 control-label">养殖天数<span class='require'>*</span></label>
	                                                    <div class="col-md-2 ">
	                                                    	<input id="breedDays"  type="text"  class="form-control" value="${obj.taskVO.categoryVO.breedDaysTotal}" disabled/>
	                                                    	<input id="breedDaysTotal" name="breedDaysTotal" type="hidden" value="${obj.taskVO.categoryVO.breedDaysTotal}" />
	                                                    </div>
	                                                    <label class="control-label" style="margin-left:-5px;margin-top:5px;">天</label>&nbsp;&nbsp;&nbsp;
	                                                </div>
	                                                <div class="form-group">
	                                                    <label class="col-md-3 control-label">开始天数<span class='require'>*</span></label>
	                                                    <div class="col-md-2 ">
	                                                    	<input name="beginDays" type="text"  class="form-control numScope positiveInteger" 
	                                                    		<c:choose>
			                                                    	<c:when test="${!empty obj.taskVO.beginDays && obj.taskVO.beginDays !=0}">
			                                                    		value="${obj.taskVO.beginDays}"
			                                                    	</c:when>
			                                                    	<c:otherwise>
			                                                    		value="1"
			                                                    	</c:otherwise>
	                                                    		</c:choose>
	                                                    	 />
	                                                    </div>
	                                                    <label  class="control-label" style="margin-left:-5px;margin-top:5px;">天</label>
	                                                </div>
	                                                <div class="form-group">
	                                                    <label for="amount" class="col-md-3 control-label">本次养殖数量<span class='require'>*</span></label>
	                                                    <div class="col-md-2 ">
	                                                    	<input name="initAmount" type="text"  class="form-control positiveInteger" 
	                                                    	<c:if test="${!empty obj.taskVO.initAmount && obj.taskVO.initAmount !=0}">value="${obj.taskVO.initAmount}"</c:if>
	                                                    	/>
	                                                    </div>
	                                                </div>
<%-- 	                                                <div class="form-group">
	                                                    <label class="col-md-3 control-label">关联养户<span class='require'>*</span></label>
	                                                    <div class="col-md-4 input-icon  "><i class="fa fa-hand-o-right"></i>
	                                                    	<input id="userId" name="userId" type="hidden" class="form-control" value="${obj.taskVO.userId}"/>
	                                                        <input id="userName" name="userName" onclick="ev_showUser();return false;" type="text" placeholder="点击选择养户"  class="form-control" value="${obj.taskVO.userName}"/>
	                                                    </div>
	                                                </div> --%>
	                                                
	                                                <div class="form-group">
	                                                    <label class="col-md-3 control-label">关联养殖场<span class='require'>*</span></label>
	                                                    <div class="col-md-4">
															<select id="farmId" class="form-control selectpicker"  name="farmId"  data-live-search="true" data-size="5" onchange="farmChange('penId',this.value);">
																<option value="">请选择</option>
																<c:forEach var="farmVO"  items="${obj.farmList }" varStatus="stauts">
																	<option value="${farmVO.farmId }">${farmVO.farmName }</option>
																</c:forEach>
															</select>
	                                                    </div>
	                                                </div>
	                                                
	                                                <div class="form-group">
	                                                    <label class="col-md-3 control-label">关联养殖场栋舍<span class='require'>*</span></label>
	                                                    <div class="col-md-4">
															<select id="penId" class="form-control selectpicker"  name="penId"  data-live-search="true" data-size="5">
																<option value="">请选择</option>
															</select>
	                                                    </div>
	                                                </div>
	                                                
	                                                <div class="form-group">
	                                                    <label  class="col-md-3 control-label">备注</label>
	                                                    <div class="col-md-4">
	                                                        <textarea rows="3" class="form-control" name="remark">${obj.taskVO.remark}</textarea>
	                                                    </div>
	                                                </div>
	                                                
	                                            </div>
                                            	<div class="form-actions text-right pal">
	                                                <button type="submit" class="btn btn-primary start">保存并生成任务</button>&nbsp;
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
    <script src="${contextPath}/manage/vendors/iCheck/icheck.min.js"></script>
    <script src="${contextPath}/manage/vendors/iCheck/custom.min.js"></script>
    <link rel="stylesheet" href="${contextPath}/vendors/bootstrap-select/new/bootstrap-select.min.css">
	<script src="${contextPath}/vendors/bootstrap-select/new/bootstrap-select.min.js"></script>
    
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
   

   
   function ev_showCategory(){
   	var url = "${contextPath}/manage/queryCategoryForTask";
		if(navigator.userAgent.indexOf("Chrome") >0 ){
			var winOption = "height=650px,width=1150px,top=10px,left=200px,resizable=yes,fullscreen=0, location=no";
			var dialog = window.open(url,null, winOption);
		}
		else{
			var args = "dialogWidth=1150px;dialogHeight=650px";
			var dialog = window.showModalDialog(url,null,args);
			$('#categoryId').val(dialog.categoryId);
			$('#categoryName').val(dialog.categoryName);
			$('#breedDays').val(dialog.breedDaysTotal);
			$('#breedDaysTotal').val(dialog.breedDaysTotal);
			
		}
   }
   
   
   function ev_showUser(){
	   	var url = "${contextPath}/manage/queryPeopleList";
			if(navigator.userAgent.indexOf("Chrome") >0 ){
				var winOption = "height=580px,width=900px,top=10px,left=100px,resizable=yes,fullscreen=0, location=no";
				var dialog = window.open(url,null, winOption);
			}
			else{
				var args = "dialogWidth=900px;dialogHeight=580px";
				var returnVal = window.showModalDialog(url,null,args);
				document.getElementById("userId").value = returnVal.userId;
				document.getElementById("userName").value = returnVal.userName;
			}
	   }
        
        $(function()
        		{
        	
        		    // Validation
        		    $("#taskForm").validate(
        		        {
        		            // Rules for form validation
        		            rules:
        		            {
        		            	categoryName:
        		                {
        		                    required: true
        		                },
        		                beginDays:
        		                {
        		                    required: true,
        		                    number: true,
        		                    digits:true,
        		                    maxlength:4
        		                },
        		                amount:
        		                {
        		                    required: true,
        		                    number: true,
        		                    maxlength:20
        		                }/* ,
        		                userName:
        		                {
        		                    required:  true
        		                } */,
        		                initAmount:
        		                {
        		                	 required:  true,
        		                	 number: true
        		                },
        		                farmId:
        		                {
        		                    required:  true
        		                },
        		                penId:
        		                {
        		                    required:  true
        		                }
        		            },

        		            // Messages for form validation
        		            messages:
        		            {
        		            	categoryName:
        		                {
        		                    required: '品类名称不能为空'
        		                },
        		                beginDays:
        		                {
        		                	required: '开始天数不能为空',
         		                	number: '请输入正确的数字',
         		                	maxlength:'长度不能超过4个字符'
        		                },
        		                amount:
        		                {
        		                	required: '养殖数量不能为空',
         		                	number: '请输入正确的数字',
         		                	maxlength:'长度不能超过20个字符'
        		                }/* ,
        		                userName:
        		                {
        		                    required: '请选择对应的养户'
        		                } */,
        		                initAmount:
        		                {
        		                    required: '养殖数量不能为空'
        		                },
        		                farmId:
        		                {
        		                    required: '养殖场不能为空'
        		                },
        		                penId:
        		                {
        		                    required: '养殖场栋舍不能为空'
        		                }
        		            },

        		            // Do not change code below
        		            errorPlacement: function(error, element)
        		            {
        		                error.insertAfter(element.parent());
        		            }
        		        });
        		    
        		    
        		    //检测开始天数是否合法
        		    jQuery.validator.addMethod("numScope", function(value, element) {  
        		        if(value < 1 || value > $("#breedDays").val()){
        		        	return false;
        		        }else{
        		        	return true;
        		        }
        		    }, "开始天数必须大于0,且小于等于养殖天数");    
        		    
        		    //检测正整数
        		    jQuery.validator.addMethod("positiveInteger", function(value, element) {  
						var reg = /^[1-9]\d*$/;
						if(reg.test(value)){
							return true;
						}else{
							return false;
						}
						console.log(reg.test(value));
        		    }, "必须为正整数");   
        		    
        		  //BEGIN CHECKBOX & RADIO
        	        $('input[type="radio"]').iCheck({
        	            radioClass: 'iradio_square-red',
        	        	  radioClass : 'iradio_square-red', 
        	        	  increaseArea : '15%' 
        	        });
        	        
        	        $('input[name="isRequired"]').each(function(){
      	        		 $(this).on('ifClicked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
      	        			$(this).iCheck('check');
      	        		}); 
      	        	  });
        	        
        	        
        	        
        	        
        	        $('input[name="isAlert"]').each(function(){
   	        		 $(this).on('ifClicked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
   	        			$(this).iCheck('check');
   	        		 	if($('#isAlertY').is(":checked")){
   	        		 		$('#alertRange').show();
   	        		 	}
   	        		 	else{
   	        		 		$('#alertRange').hide();
   	        		 	}
   	        		}); 
   	        	  });
        	       
        		});

</script>

<script type="text/javascript">
	function farmChange(obj, id) {
	    $.ajax({
	        type: 'POST',
	        url: '${contextPath}/manage/getFarmPenByFarmId',
	        data: {
	            "farmId": id
	        },
	        async: false,
	        dataType: 'json',
	        success: function(result) {
	            for (var i = $('#' + obj)[0].children.length; i > 1; i--) {
	                $('#' + obj)[0].children[i - 1].remove();
	            }
	            $('#' + obj).selectpicker('refresh');
	            if (result.result == 'OK') {
	                if (result.farmPenList.length > 0) {
	                    for (var i = 0; i < result.farmPenList.length; i++) {
	                        var tempPenId = result.farmPenList[i].penId;
	                        var tempPenName = result.farmPenList[i].penName;
	                        $('#' + obj).append("<option value=\"" + tempPenId + "\">" + tempPenName + "</option>");
	                    }
	                    $('#' + obj).selectpicker('refresh');
	                }
	            } else {
	                toastr['error'](result.msg, "");
	            }
	        }
	    });
	}
</script>


</body>

</html>