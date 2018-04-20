<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<%@include file="../include/header.jsp"%>
<link type="text/css" rel="stylesheet"
	href="${contextPath}/manage/vendors/jquery-tablesorter/themes/blue/style-custom.css">
</head>

<style>
.modal-body{
	height: auto !important;
}
.table th,.table td {
	text-align: center;
	vertical-align: middle !important ；//垂直居中
}

.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td
	{
	vertical-align: middle !important ；//垂直居中
}
.goods-pic{
	display: inline-block;
    height: 50px;
    width: 50px;
    vertical-align: middle;
    margin-right: 5px;
}
.goods-pic img{
	width: 50px;
}
._goods-list{
	position: absolute;
	left: 0;
    z-index: 1000;
    display: block;
    background: #fff;
    border: 1px solid #33485c;
    max-height: 300px;
    overflow: auto;
    display: none;
}
._goods-list div{
	position: relative;
    cursor: pointer;
    color: #555;
    background: #FFF;
    line-height: 50px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    text-align: left;
}
input[name="goodId"]{
	height: 34px;
	width: 100%;
}
._item:hover{
	background-color: #ddd;
}
._item-clone{
	text-align: left;
	white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    cursor: pointer;
}
.table>tbody>tr>td{
	vertical-align: middle;
}
.show-goods{
	position: absolute;
    right: 0;
    line-height: 34px;
    padding: 0 5px;
}
.show-goods:hover{
	color: #e74c3c;
    cursor: pointer;
}
#goodslist-tbody tr td img{
	height: 40px;
}
.modal-body .search-group{
	padding-bottom: 15px;
	border-bottom: 1px solid #ddd;
}
.modal-body .search-group input{
	width: 400px;
	height: 34px;
	padding: 0 5px;
}
.modal-body .search-group button{
	width: 100px;
	height: 34px;
	font-family: 'Microsoft Yahei'
}
#goodslist-tbody input{
	text-align: center;
}
._goods-list .goods-list-load,
.isFoot{
	line-height:50px;
	text-align:center;
	color:#e74c3c;
	opacity: 1;
	transition: opacity 1s;
}
.form-con-me{
	padding: 0 12px;
    background: none;
    border: none;
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
					<ol class="breadcrumb page-breadcrumb pull-left">
						<li><i class="fa fa-home"></i>&nbsp;<a
							href="${contextPath}/manage/showIndex">首页</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li><a href="#">库存管理</a>&nbsp;&nbsp;<i
							class="fa fa-angle-right"></i>&nbsp;&nbsp;</li>
						<li class="active">新增入库</li>
					</ol>
<%-- 					<jsp:include page="../common/searchBar.jsp" flush="true">
						<jsp:param name="defaultBtn" value="搜库存" />
						<jsp:param name="placeholder" value="请输入物料名称/编码/关键字" />
						<jsp:param name="searchType" value="4" />
					</jsp:include> --%>
					<div class="clearfix"></div>
				</div>
				<!--END TITLE & BREADCRUMB PAGE-->

				<!--BEGIN CONTENT-->



				<div class="page-content">
					<div id="table-advanced" class="row">
						<div class="col-lg-12">
							<ul id="tableadvancedTab" class="nav nav-tabs">
								<li class="active"><a href="#table-sticky-tab"
									data-toggle="tab">新增入库</a></li>
							</ul>
							<div id="tableadvancedTabContent" class="tab-content">
								<div id="table-sorter-tab" class="tab-pane fade in active">
									<div class="row">
										<div class="col-lg-12">
											<div class="portlet box">
												<div class="portlet-body">
													<form id="newInStorage" class="form-horizontal" method="POST">
														<div class="panel-body pan">
															<div class="form-body pal">
																<div class="row">
																
																	<div class="col-md-6">
																		<div class="form-group">
																			<label for="单号" class="col-md-3 control-label">单号
																				<span class='require'>*</span>
																			</label>
																			<div class="col-md-9">
																				<input name="billCode" type="text" placeholder="" class="form-control" value="${obj.billCode}" />
																			</div>
																		</div>
																	</div>
																	<div class="col-md-6">
																		<div class="form-group">
																			<label for="入库类型" class="col-md-3 control-label">入库类型<span
																				class='require'>*</span>
																			</label>
																			<div class="col-md-9">
																				<select id="storageType" name="storageType"
																					class="form-control">
																					<option selected="selected" value="采购入库">采购入库</option>
																					<option value="其他入库">其它入库</option>
																				</select>
																			</div>
																		</div>
																	</div>
																</div>
																<div class="row">
																	<div class="col-md-6">
																		<div class="form-group">
																			<label class="col-md-3 control-label">入库日期<span
																				class='require'>*</span></label>
																			<div class="col-md-9">
																				<input type="text" readonly="readonly" id="createTime" name="createTime" autocomplete="off" placeholder="请选择时间" class="form-control" />
																			</div>
																		</div>
																	</div>
																	<div class="col-md-6">
																		<div class="form-group">
																			<label for="isList" class="col-md-3 control-label">制表人
																				<span class='require'>*</span>
																			</label>
																			<div class="col-md-9">
																				<input type="text" id="billMaker" name="billMaker" class="form-control" value="${sessionScope.USERVO.userName}"/>
																			</div>
																		</div>
																	</div>
																	<div class="col-md-6">
																		<div class="form-group">
																			<label for="仓库" class="col-md-3 control-label">仓库<span
																				class='require'>*</span>
																			</label>
																			<div class="col-md-9">
																				<select id="storeId" name="storeId"
																					class="form-control" onchange="">
																					<c:forEach var="storeVO" items="${obj.storeList}" varStatus="status">
																						<option value="${storeVO.storeId}" >${storeVO.storeName}</option>
																					</c:forEach>
																				</select>
																			</div>
																		</div>
																	</div>
																</div>
																<div class="row" style="margin-top:30px;">
																	<div class="col-lg-12">
																		<table
																			class="table table-hover table-striped table-bordered table-advanced tablesorter">
																			<thead>
																				<tr>
																					<th width="28%">物料</th>
																					<th width="25%">批次号</th>
																					<th width="10%">单位</th>
																					<th width="10%">单价</th>
																					<th width="10%">入库数量</th>
																					<th>备注</th>
																					<th width="10%">操作</th>
																				</tr>
																			</thead>
																			<tbody id="storage_tbody">
																				<tr id="tr_1">
																					<td class="select-goods-area">
																							<div style="position:relative">
																								<input type="text" name="goodId"/>
																								<div class="_goods-list">
																									<div class="_item">
																										<span>暂无数据.</span>
																									</div>
																								</div>
																								<div class="goods-clone"></div>
																								<span class="glyphicon glyphicon-list show-goods"></span>
																							</div>
																						</td>
																					<td>
																					  <div style="display: inline">
																					    <input id="batchNumber" name="batchNumber" type="text" class="form-control" onchange="changeBatch(this)"
																								style="float: left; display: inline; width: 60%" />

																					  </div> 
																					  <a href="#" style="float: left; margin-top: 6px" onclick="ev_batchs(this);">&nbsp;&nbsp;<i
																							class="fa fa-share-square-o"></i>从历史中选取
																					  </a>
																					</td>
																					<td>
																						<div class="form-control"></div>
																					</td>
																					<td><input id="price" name="price" type="text"
																						class="form-control" /></td>
																					<td>
																					  <input id="storageNum" name="storageNum" onkeyup="input_checked(this)" type="text" class="form-control" />
																					</td>
																					<td><input id="remark" name="remark"
																						type="text" class="form-control" /></td>
																					<td>
																						<button type="button" class="btn" id="del_tr_1" name="del_tr_1" value="删除" onclick="del_tr(1)" class="col-md-3 control-label">
																							<i class="fa fa-times"></i>&nbsp;&nbsp;删除
																						</button>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																		<div class="col-md-6" style="margin-left:-15px;">
																			<button type="button" class="btn" id="addList" name="addList" class="col-md-3 control-label">
																				<i class="fa fa-plus"></i>&nbsp;&nbsp;添加
																			</button>
																		</div>
																	</div>
																</div>
															</div>
														</div>
														<hr />
														<div class="text-right pal pull-left">
															<button id="submitBtn" type="button" class="btn btn-primary" onclick="ev_save(this)">保存</button>
															&nbsp;
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
					<div class="modal fade bs-example-modal-lg" id="chooseGoods" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				  		<div class="modal-dialog modal-lg">
				    		<div class="modal-content">
					      		<div class="modal-header">
					        		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					        		<h4 class="modal-title" id="myModalLabel">选择物料</h4>
					      		</div>
						     	<div class="modal-body" style="overflow: auto;height:700px;">
						     		<div class="search-group">
						     			<input type="text"/>
						     			<button class="search-goods-btn" style="position:absolute;top:15px;right:42%;">搜索</button>
						     		</div>
						     		<table class="table">
						     			<thead>
						     				<tr>
						     					<th width="2%"></th>
						     					<th width="10%">略图</th>
						     					<th width="10%">物料编码</th>
						     					<th width="">物料名称</th>
												<th width="15%">单位</th>
												<th width="10%">入库数量</th>
						     				</tr>
						     			</thead>
						     			<tbody id="goodslist-tbody">
						     				
						     			</tbody>
						     		</table>
						      	</div>
						      	<div class="modal-footer">
						      		<div class="pagination-panel" style="float: left;">
										<a id="pageUp" class="btn btn-sm btn-success btn-prev gw-prev">
											<i class="fa fa-angle-left"></i>
										</a>
										<input id="currentPage" type="text" maxlenght="5" value="1"
											class="pagination-panel-input form-control input-mini input-inline input-sm text-center gw-page"/>
										<a id="pageDown" class="btn btn-sm btn-success btn-prev gw-next">
											<i class="fa fa-angle-right"></i>
										</a> 
										<span id="pagination-info">共有  页 | 合计  条记录</span>
									</div>
						       		<button type="button" class="btn btn-primary" id="comfirm-choose-goods">确定</button>
						        	<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						      	</div>
				    		</div>
				  		</div>
					</div>
				</div>
				<!--BEGIN FOOTER-->
				<%@ include file="../include/footer.jsp"%>
				<!--END FOOTER-->
				<!--END PAGE WRAPPER-->

				<!--LOADING SCRIPTS FOR PAGE-->
				<script
					src="${contextPath}/manage/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
				<script src="${contextPath}/manage/vendors/moment/moment.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-clockface/js/clockface.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
				<script
					src="${contextPath}/manage/vendors/bootstrap-switch/js/bootstrap-switch.min.js"></script>
				<script
					src="${contextPath}/manage/vendors/jquery-maskedinput/jquery-maskedinput.js"></script>
				<script src="${contextPath}/manage/vendors/charCount.js"></script>
				<script src="${contextPath}/manage/js/form-components.js"></script>
				<!--日历控件-->
				<script type="text/javascript"
					src="${contextPath}/manage/js/calendarJs/jedate.js"></script>
				<script src="${contextPath}/manage/js/chooseGoods.js"></script>

				<script type="text/javascript">
    //菜单初始化
    activeMenu("orderManageMenu","supplyOrderUL","inStorage");
    
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
        	window.location.href = "${contextPath}/manage/inStorage";
        },600);
    }
    else if(result=='FAIL'){
    	toastr['error'](message, "");
    }
        
   function ev_back(){
   	window.history.back();
   }
   
   function ev_save(obj){
	   $("#submitBtn").attr("disabled",true);
   }
   
   /* function submit(){
	   document.getElementById("goodsForm").submit();
   } */
   
   //只能输入数字和小数点
   function input_checked(obj){
	   obj.value = obj.value.replace(/[^\d.]/g,"");
   }
   
   
$(function(){
	   
	   var tds =  '<td>'
	   			+ '<div style="display: inline"><input id="batchNumber" name="batchNumber" type="text" class="form-control" onchange="changeBatch(this)" style="float: left; display: inline; width: 60%" /></div>'
	   		 	+ '<a href="#" style="float: left; margin-top: 6px" onclick="ev_batchs(this);">&nbsp;&nbsp;<i class="fa fa-share-square-o"></i>从历史中选取</a>'
	   			+ '</td>'
        		+ "<td><div class='form-control'></div></td>"
        		+ '<td><input id="price" name="price" type="text" class="form-control" /></td>'
        		+ '<td><input id="storageNum" name="storageNum" onkeyup="input_checked(this)" type="text" class="form-control" /></td>'
   				+ "<td><input name='remark' type='text' placeholder='' class='form-control' /></td>";
   				
   		var modalTd = "<td><div class='form-control'></div></td>";
   		//物料选定的回调函数
   		var goodsChange = function(obj,num,id,modal,selectedUnitVal) {
   			console.log(selectedUnitVal);
   			if(!modal){
	   			var ran = Math.floor(Math.random()*1000);
	   			var unitName = $(obj).find('.goods-clone div[unitname]').attr('unitname');
	   			var numTdInput = $(obj).find('td input[name="storageNum"]');
	   			var unitTd = obj.children[2].children[0];
	   			unitTd.innerHTML = unitName;
	   			numTdInput.val(num?num:1);
   			}
	   			var td = obj.children;
   			$.post('${contextPath}/manage/getOrderGoodsInfo',{goodId: id, isAll: 'true'},function(data){
   				//组装多单位下拉框
				var str = "<div class='form-control form-con-me'><select data-selectUnit='"+id+"' name='selectUnit' id='unit"+id+ran+"' class='dropdown2' style='width:120%;margin-left:-10px;border-color: #e5e5e5;' >";
				var unitList = data.unitRelevanceList;
				var firstUnit = {};
				for(var i=0;i<unitList.length;i++){
					var property = '';
					if(i==0){
						firstUnit = unitList[i];
					}
					if(unitList[i].count == selectedUnitVal){
						property = 'selected=selected';
					}
					str = str+"<option "+property+" value='"+unitList[i].count+"'>"+unitList[i].unitName+"</option>"
				}
				str=str+"</select></div>";
				if(modal){
					td[4].innerHTML = str;
				}
				else{
					td[2].innerHTML = str;
				}
   			});
   		}
	   _chooseGoods({
		   tbodyId: 'storage_tbody',
		   isNumChange: false,
		   domainUrl: '${QUPLOADIMG}',
		   insertTd: tds,
		   insertModalTd: modalTd,
		   notGetGoodsInfo: true,
		   notCover: true,
		   modalGetUnit: true,
		   goodsChangeHandler: goodsChange,
		   startUsingMoreNuit: true,
	   });
   })
   
    //删除规格
	function del_tr(n, opra){
	var trNumber = $('#storage_tbody tr').length;
	if(trNumber <= 1 && opra !='canDel') {
		return toastr['error']('至少保留和选择一个物料！', "");
	}
		$("#tr_" + n).remove();
   	}
    
	 $(function() {
         $("#submitBtn").click(function(){
    		if(ev_check()){
    		  $.ajax({
                  url : "${contextPath}/manage/saveInStorage",
                  type: "POST",
                  data:$('#newInStorage').serialize(),
                  error: function(request) {
                	 
                      alert("链接异常");
                  },
                  dataType:"json",
                  success: function(data) {
                      if (data.result == 'OK') {
                          toastr['success'](data.msg,"");
                          setTimeout(function(){
                        	  window.location.href ="${contextPath}/manage/inStorage";
          	            },300);
                      } else {
                     	 toastr['error'](data.msg, "");
                      }
                  }
              });
    		}else{
    			$("#submitBtn").attr("disabled",false);
    		}
    		 return false;
    	});
    });
    
	function ev_check(){
    	var bol = true;
    	var createTime = $("#createTime").val();
    	var billCode = $("#billCode").val();
    	var goodId = document.getElementsByName("goodId");
    
    	//alert(goodId[0].value);
        var storageNum = document.getElementsByName("storageNum");
        var price = document.getElementsByName("price");
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
    	for(var i = 0; i < goodId.length; i++){
        	if(goodId[i].value == ""){
    			bol = false;
    			message = "请选择一个物料！";
    		}
    	} 
    	
    	for(var i = 0; i < storageNum.length; i++){
        	if(storageNum[i].value == ""){
    			bol = false;
    			message = "请输入数量！";
    		}
    	} 
    	for(var i = 0; i < price.length; i++){
        	if(price[i].value == ""){
    			bol = false;
    			message = "请输入单价！";
    		}
    	} 
    	if(!bol)
    		toastr['error'](message, "");
    	return bol;
        }

   
   /* var specNum = 1;
   function addSpec(specNum){
	   var spec = "<div id='spec_" + specNum + "' name='spec_"+ specNum + "' class='row' ><div class='col-md-2'><input name='spec" + n + "' type='text' placeholder='规格"+ specNum + "' class='form-control' /></div><div class='col-md-6'><input name='' type='text' placeholder='' class='form-control' /></div></div>";
	   specNum++;
	   document.getElementById("spec").innerHTML += spec;
   } */
   
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
	
    function ev_batchs(obj){
	   var goodId = $(obj).parent().parent().find('input[name="goodId"]').val();
	   var unitname = $(obj).parent().parent().find('.goods-clone>div[unitname]').attr('unitname');
	   console.log(unitname);
	   if(goodId!=""){
		   var url="${contextPath}/manage/showBatchNumber?id="+obj.parentNode.parentNode.id+"&goodId="+goodId;
		   if(navigator.userAgent.indexOf("Chrome")>0){
			   var winOption = "height=650px,width=850px,top=200px,left=850px,resizable=yes,fullscreen=0, location=no";
				var dialog = window.open(url, null, winOption);
		   }else{
			   var args = "dialogWidth=1150px;dialogHeight=650px";
				var dialog = window.showModalDialog(url, null, args);
				document.getElementById(dialog.id).children[1].innerHTML= dialog.html1;
				document.getElementById(dialog.id).children[3].innerHTML=dialog.html2;
		   }
		   //$(obj).parent().next().find('.form-control').html(unitname);
	   }else{
		   toastr['error']("请先选择一个物料！", "");
	   }
	   
   	} 
   
  function  changeBatch(obj){
	  $(obj.parentNode.parentNode.parentNode.children[3].children[0]).removeAttr("disabled");
   }
  
  function  changeGood(obj){
	  var unitName=$(obj).find("option:selected").attr("unitName");
	  $(obj).parent().next().html(unitName);
   }

</script>
</body>

</html>