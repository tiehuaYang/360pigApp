<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>

<link type="text/css" rel="stylesheet" href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css"></head>

 <link type="text/css" rel="stylesheet" href="vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css">
    <link type="text/css" rel="stylesheet" href="vendors/bootstrap-timepicker/css/bootstrap-timepicker.min.css">

   <style>
   .table th, .table td { 
text-align: center; 
vertical-align:middle !important；//垂直居中
}

.table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td, .table>tbody>tr>td, .table>tfoot>tr>td{
vertical-align:middle !important；//垂直居中
}
</style>

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
                        <div class="page-title">新增出库</div>
                    </div>
                    <ol class="breadcrumb page-breadcrumb">
                        <li><i class="fa fa-home"></i>&nbsp;<a href="${contextPath }/manage/showIndex">首页</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li><a href="#">库存管理</a>&nbsp;&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
                        <li class="active">新增出库</li>
                    </ol>
                    <div class="clearfix"></div>
                </div>
                <!--END TITLE & BREADCRUMB PAGE-->
                
                <!--BEGIN CONTENT-->
                
                <div class="page-content">
                    <div id="table-advanced" class="row">
                        <div class="col-lg-12">
                            <ul id="tableadvancedTab" class="nav nav-tabs">
                                <li class="active"><a href="#table-sticky-tab" data-toggle="tab">新增出库</a></li>
                            </ul>
                            <div id="tableadvancedTabContent" class="tab-content">
                                <div id="table-sorter-tab" class="tab-pane fade in active">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="portlet box">
                                            	<div class="portlet-body">
		                                            <form id="newOutStorages" action="${contextPath}/manage/saveOutStorages" class="form-horizontal" method="POST"  >
                                                		<div class="panel-body pan">
                                                        <div class="form-body pal">
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="单号" class="col-md-3 control-label">单号 <span class='require'>*</span>
                                                                        </label>
                                                                        <div class="col-md-9">
                                                                            <input name="billCode" type="text" placeholder="" class="form-control" value="${obj.billCode}" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="出库类型" class="col-md-3 control-label">出库类型<span class='require'>*</span>
                                                                        </label>
                                                                        <div class="col-md-9">
                                                                            <select id="accessoryId" name="storageType" class="form-control">
                                                                            	<option selected="selected" value="销售出库">销售出库</option>
                                                                                <option value="其他出库">其它出库</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                						<label class="col-md-3 control-label">出库日期<span class='require'>*</span></label>
                                                						<div class="col-md-9">
                                                    						
                                                        						<input readonly="readonly" type="text" id="createTime" name="createTime" placeholder="请选择时间" class="form-control" />
                                                    					
                                                						</div>
                                            						</div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="isList" class="col-md-3 control-label">制表人 <span class='require'>*</span>
                                                                        </label>
                                                                        <div class="col-md-9">
                                                                            <input type="text" id="billMaker" name="billMaker" class="form-control" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                 
                                                            </div>
                                                            
                                                            <div class="row">
							                                        <div class="col-lg-11">
							                                            <table class="table table-hover table-striped table-bordered table-advanced tablesorter">
							                                                <thead>
							                                                    <tr>
							                                                        <th  width="30%">物料</th>
							                                                        <th  width="10%">出库数量</th>
							                                                    	<th >任务批次号</th>
							                                                        <th>备注</th>
							                                                        <th width="10%">操作</th>
							                                                    </tr>
							                                                </thead>
							                                                <tbody id="storage_tbody">
							                                                    <tr id="tr1">
							                                                        <td>
							                                                        	<select id="materialId" name="materialId" class="form-control">
							                                                        	
							                                                        		<c:forEach var="materialList" items="${obj.materialList}" varStatus="status">
                                                                            					<c:if test="${materialList.state=='0' }">
                                                                            					<option value="${materialList.materialId}">${materialList.materialName}</option>
                                                                            				</c:if>
                                                                            				</c:forEach>
                                                                            			</select>
                                                                            		</td>
							                                                        <td>
							                                                        	<input  name="storageNum" onkeyup="input_checked(this)" type="text" placeholder="" class="form-control" value=""/>
							                                                        </td>
							                                                       <td>
							                                                       
							                                                        <input id="batchNO" name="batchNO" type="text" readonly="readonly" onclick="ev_showTask(this)" class="form-control" />
							                                                       </td>
							                                                        <td>
					                                                                    <input name="remark" type="text"  class="form-control" />
							                                                    	</td>
							                                                    	<td>
							                                                    		<button type="button" class="btn" id="del_tr_1" name="del_tr_1" value="删除" onclick="del_tr(1)" class="col-md-3 control-label"><i class="fa fa-times"></i>&nbsp;&nbsp;删除</button>
							                                                    	</td>
							                                                    </tr>
							                                                </tbody>
							                                            </table>
							                                            <div class="col-md-6">
                                                                        	<button type="button" class="btn" id="addList" name="addList" class="col-md-3 control-label"><i class="fa fa-plus"></i>&nbsp;&nbsp;添加</button>
                                                                    	</div>
							                                        </div>
							                                    </div>
                                                            </div>
                                                        </div>
                                                        <hr/>
                                                        <div class="form-actions text-right pal pull-left">
                                                            <button id="submitBtn" type="button" onclick="ev_submit()" class="btn btn-primary start">保存</button>&nbsp;
	                                                		<button type="button" class="btn btn-green" onclick="ev_back()">取消</button>
                                                        </div>
                                                    </form>
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
    <script src="${contextPath}/manage/js/jquery-1.10.2.min.js"></script>
    <script src="${contextPath}/manage/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="${contextPath}/manage/js/jquery-ui.js"></script>
    <!--loading bootstrap js-->
    <script src="${contextPath}/manage/vendors/bootstrap/js/bootstrap.min.js"></script>
    <script src="${contextPath}/manage/vendors/bootstrap-hover-dropdown/bootstrap-hover-dropdown.js"></script>
    <script src="${contextPath}/manage/js/html5shiv.js"></script>
    <script src="${contextPath}/manage/js/respond.min.js"></script>
    <script src="${contextPath}/manage/vendors/metisMenu/jquery.metisMenu.js"></script>
    <script src="${contextPath}/manage/vendors/slimScroll/jquery.slimscroll.js"></script>
    <script src="${contextPath}/manage/vendors/jquery-cookie/jquery.cookie.js"></script>
    <script src="${contextPath}/manage/vendors/iCheck/icheck.min.js"></script>
    <script src="${contextPath}/manage/vendors/iCheck/custom.min.js"></script>
    <script src="${contextPath}/manage/vendors/jquery-notific8/jquery.notific8.min.js"></script>
    <script src="${contextPath}/manage/vendors/jquery-highcharts/highcharts.js"></script>
    <script src="${contextPath}/manage/js/jquery.menu.js"></script>
    <script src="${contextPath}/manage/vendors/jquery-pace/pace.min.js"></script>
    <script src="${contextPath}/manage/vendors/holder/holder.js"></script>
    <script src="${contextPath}/manage/vendors/responsive-tabs/responsive-tabs.js"></script>
    <script src="${contextPath}/manage/vendors/jquery-news-ticker/jquery.newsTicker.min.js"></script>
    <script src="${contextPath}/manage/vendors/moment/moment.js"></script>
    <script src="${contextPath}/manage/vendors/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script src="${contextPath}/manage/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <!--CORE JAVASCRIPT-->
    <script src="${contextPath}/manage/js/main.js"></script>
    <!--LOADING SCRIPTS FOR PAGE-->
    <script src="${contextPath}/manage/vendors/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script src="${contextPath}/manage/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <script src="${contextPath}/manage/vendors/moment/moment.js"></script>
    <script src="${contextPath}/manage/vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${contextPath}/manage/vendors/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
    <script src="${contextPath}/manage/vendors/bootstrap-clockface/js/clockface.js"></script>
    <script src="${contextPath}/manage/vendors/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
    <script src="${contextPath}/manage/vendors/bootstrap-switch/js/bootstrap-switch.min.js"></script>
    <script src="${contextPath}/manage/vendors/jquery-maskedinput/jquery-maskedinput.js"></script>
    <script src="${contextPath}/manage/vendors/charCount.js"></script>
    <script src="${contextPath}/manage/js/form-components.js"></script>
         <!--日历控件-->
    <script type="text/javascript" src="${contextPath}/js/calendarJs/jedate.js"></script>
    <script type="text/javascript">
    //菜单初始化
    activeMenu("stockManage","stockUL","outStorages");
    jeDate({
		dateCell:"#createTime",
		format:"YYYY-MM-DD hh:mm:ss",
		isinitVal:false,
		isTime:true, //isClear:false,
		//minDate:"2014-09-19 00:00:00",
		okfun:function(val){
				//alert(val);
		}
    })
    
    $(document).ready(function(){
	}); 
    
    /* window.onload = function(){
    	var a = document.getElementById("mPrice").value;

    	document.getElementById("orderPrice").value = a * 0.9;

    	}; */
    
    var result = "${obj.result}";
    var message = "${obj.msg}";
    if(result=='OK'){
    	toastr['success'](message, "");
        setTimeout(function(){
        	window.location.href = "${contextPath}/manage/outStorages";
        },600);
    }
    else if(result=='FAIL'){
    	toastr['error'](message, "");
    }
        
   function ev_back(){
   	window.history.back();
   }
   
   /* function submit(){
	   document.getElementById("goodsForm").submit();
   } */
   
   function ev_showCategory(){
   	var url = "${contextPath}/manage/queryCategoryForTask";
		if(navigator.userAgent.indexOf("Chrome") >0 ){
			var winOption = "height=650px,width=1150px,top=10px,left=200px,resizable=yes,fullscreen=0, location=no";
			var dialog = window.open(url,window, winOption);
		}
		else{
			var args = "dialogWidth=1150px;dialogHeight=650px";
			var dialog = window.showModalDialog(url,null,args);
			$('#categoryId').val(dialog.categoryId);
			$('#categoryName').val(dialog.categoryName);
			$('#breedDays').val(dialog.breedDaysTotal);
			$('#breedDaysTotal').val(dialog.breedDaysTotal);
			
		}
		
		search();
		
   }
   //只能输入数字和小数点
   function input_checked(obj){
	   obj.value = obj.value.replace(/[^\d.]/g,"");
   }
   
   $(function(){
		   $("#addList").click(function(){
			   var ran = Math.floor(Math.random()*1000);
			   var  tr = "<tr id='tr" + ran + "'>"
               				+ "<td>"
           					+ "<select id='materialId' name='materialId' class='form-control'>"
           						+ "<option value=''></option>"
           						+ "<c:forEach var='materialList' items='${obj.materialList}' varStatus='status'>"
   									+ "<c:if test='${materialList.state=="0" }'><option value='${materialList.materialId}'>${materialList.materialName}</option></c:if>"
   								+ "</c:forEach>"
   							+ "</select>"
   						+ "</td>"
           				+ "<td>"
           					+ "<input  name='storageNum' onkeyup='input_checked(this)' type='text' placeholder='' class='form-control' value=''/>"
           				+ "</td>"
           				+ "<td>"
           				+ "<input id='batchNO' name='batchNO' readonly='readonly' type='text' onclick='ev_showTask(this)' placeholder='' class='form-control' />"
   					+ "</td>"
           				+ "<td>"
               				+ "<input name='remark' type='text' placeholder='' class='form-control' />"
       					+ "</td>"
       					+ "<td>"
       						+ "<button type='button' class='btn' onclick='del_tr("+ ran +")' class='col-md-3 control-label'><i class='fa fa-times'></i>&nbsp;&nbsp;删除</button>"
       					+ "</td>"
      				 + "</tr>";
			   $("#storage_tbody").append(tr);
		   });
		   
		   //价格联动
		   $("#mPrice").change(function(){
			   var mPrice = parseInt(document.getElementById("mPrice").value);
		   	   $('input[name=orderPrice]').each(function(){
		   		   var discount = parseInt($(this).parents('td').siblings('.discounttd').text());
		   		   $(this).val(discount*mPrice/100);
		   	   });
		   });
		   
		   //是否允许订货
		   $("input[name='isOrdered']").each(function(){
			   
		   });
	}); 
 //删除规格
	function del_tr(n, opra){
		var trNumber = $('#storage_tbody .btn').length;
		if(trNumber <= 1 && opra !='canDel') {
			return toastr['error']('至少保留和选择一个商品！', "");
		}
		$("#tr" + n).remove();
		$(".tr" + n).remove();
  	}
    //删除图片
	function ev_deletePic(id,goodId){
    	if(window.confirm("确定要删除这张图片吗？")){
      	  var url = "${contextPath}/manage/delPicture?pictureId="+id+"&billId="+goodId;
      	    common_ajax(url,function(data){
      	    	toastr['success']("删除成功", "");
	            setTimeout(function(){
	            	location.reload();
	            },300);
  		  });
      	}
    }
    
    
	function ev_submit(){
    	if(ev_check()){
    		$.ajax({
	        	  type: 'POST',
	        	  url: '${contextPath}/manage/saveOutStorages',
	        	  data: $("#newOutStorages").serialize(),
	        	  async: false,  
	              dataType: 'json',
	        	  success: function(result){
	        		  	if(result.result == 'OK'){
	        		  		toastr['success'](result.msg, "");
	                    	setTimeout(function(){
	                    		var url = '${contextPath}/manage/outStorages';
	                        	window.location.href = url;	
	                    	},1000);
	    	        	}else{
	    	        		toastr['error'](result.msg, "");
	    	        	}
	        	  }
		});
    	}else{
    		
    		//window.location.reload();
    	}
    }
    
	function ev_check(){
    	var bol = true;
    	var createTime = $("#createTime").val();
    	var billCode = $("#billCode").val();
    	var accessoryId = document.getElementsByName("materialId");
    	
    	//alert(goodId[0].value);
        var storageNum = document.getElementsByName("storageNum");
    	var billMaker = $("#billMaker").val();
    	
    	var message="";
    	if(createTime == ""){
    		bol = false;
    		message = "请选择时间！";
    	}
    	if(billMaker == ""){
    		bol = false;
    		message = "请填入制表人！";
    	}
    	if(billCode == ""){
    		bol = false;
    		message = "制单错误！";
    	}
    	
    	
    	for(var i = 0; i < accessoryId.length; i++){
    		
        	if(accessoryId[i].value == ""){
    			bol = false;
    			message = "请选择一个物料！";
    		}
        	if(storageNum[i].value == ""){
    			bol = false;
    			message = "请输入数量！";
    		}
        	if(storageNum[i].value==0){
        		bol=false;
        		message="出库数量不能为0，请重新输入！";
        	}
        	var num = storageNum[i].value;
        	//alert(num);
        	<c:forEach var="accessoryVO" items="${obj.materialList}"> 
        	
        	if("${accessoryVO.materialId}"==accessoryId[i].value){
        	
        		var quantity = "${accessoryVO.stockVO.quantity}";
        		//alert(num);
        		if(parseFloat(num) > parseFloat(quantity)){
        			bol = false;
        			message = "${accessoryVO.materialName}"+"库存不足！当前库存为"+quantity+"！";
        		}
        	}
        	</c:forEach>
    	} 
    	/* for(var i = 0; i < storageNum.length; i++){
        	if(storageNum[i].value == ""){
    			bol = false;
    			message = "请输入数量！";
    		}
    	}  */
    
    	if(!bol)
    		alert(message);

    	return bol;
        }
   
   /* var specNum = 1;
   function addSpec(specNum){
	   var spec = "<div id='spec_" + specNum + "' name='spec_"+ specNum + "' class='row' ><div class='col-md-2'><input name='spec" + n + "' type='text' placeholder='规格"+ specNum + "' class='form-control' /></div><div class='col-md-6'><input name='' type='text' placeholder='' class='form-control' /></div></div>";
	   specNum++;
	   document.getElementById("spec").innerHTML += spec;
   } */
   
  
        
      
        
        
        function ev_showTask(obj) {
    		
    		var url = "${contextPath}/manage/showPicTask?id="+obj.parentNode.parentNode.id;
    		if (navigator.userAgent.indexOf("Chrome") > 0) {
    			var winOption = "height=650px,width=1150px,top=10px,left=200px,resizable=yes,fullscreen=0, location=no";
    			var dialog = window.open(url, window, winOption);

    		} else {

    			var args = "dialogWidth=1150px;dialogHeight=650px";
    			var dialog = window.showModalDialog(url, null, args);
    			$('#taskId').val(dialog.taskId);
    			$('#batchNO').val(dialog.batchNO);
    		

    		}
    	}

</script>
</body>

</html>