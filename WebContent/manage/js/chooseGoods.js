
/*parameter
 * tbodyId 主要table的tbody的id
 * isNumChange 是否启用计算总价功能
 * domainUrl 域名, 主要用于图片路径显示
 * insertTd 插入的表格列( 默认表格列只有第一列用来显示下拉商品, 和最后一列用来删除表格行, 其他的只要是从这里传递 )
 * insertModalTd 插入的模态框表格列( 默认表格列有前四列 和最后一列, 其他的只要是从这里传递 )
 * notGetGoodsInfo 不需要获取商品信息  默认是false
 * notCover  不需要覆盖相同的商品  默认是false
 * modalGetUnit 是否获取模态框中的单位  默认true
 * goodsChangeHandler  每次选择商品的回调函数
 * getGoodsSpecInfo  获取商品批次号信息
 * orderNumIn  模态框中数量赋值的单元格下标
 * needSendCompanyId  是否获取当前行商品公司ID传递到modal
 * needStorageNum modal中是否需要显示入库数量的列
 * isRadio modal中的操作勾选为单选 
 * return_Func 
 * startUsingMoreNuit 是否启用了下拉选择多单位 默认是false(目前只有notGetGoodsInfo为true是才有用在模态框单位里)
 */
		 

var goodsListData = [];//下拉滚动商品列表数据队列
var focusInput;//被点中的下拉input
var goodsWidth = [];//商品列表宽度
var checkedGoodsArr = [];//模态框中被选中的商品数据队列
var showGoodsListModalBtn = '';//当前被点中的弹出模态框按钮
var currentPage = 0;//翻页，当前页码
var pageSize = 10;//每一页默认条数
var pageCount = 0;//翻页总页数
var recordCount = 0;//翻页数据总条数
var pageGoodsList = [];//模态框翻页，当前页数据
var newCompanyId = '';//当前行商品公司ID
var newGoodsName = '';//当前行商品名称

function _chooseGoods(parameter){
	   
	if(parameter.run_Func){
		getGoodsList(1);
		addModalTr(pageGoodsList,'needNum');
		return;
	}
	if(parameter != undefined && typeof(parameter) == 'object') {
		if(parameter.notGetGoodsInfo) {
			getGoodsInfo = function() {
				//如果不需要获取商品信息则什么也不做
			}
		}
		if(parameter.needStorageNum == undefined){
			//needStorageNum默认为true( 如果不传就是默认true )
			parameter.needStorageNum = true;
		}
	}
	else{
		return alert('chooseGoods参数没有或参数格式不对');
	}

	

	   
	   /**
	   	addTr:为table新加一行
	   		@param hasObj 必须，isAdd为新增一行无数据行
	   		@param hasObj 必须，是对象时,新增一行数据行
	   		@param orderNum, 新增一行数据的下单数量
	   		@param priceo, 新增一行数据的订货价
	    */
	   function addTr(hasObj,orderNum,priceo){
		   var goodId = '';
		   if(hasObj != 'isAdd') {
			   //如果不是新增的空白行, 意味着就是 从模态框选择的数据新增的数据行
			   goodId = hasObj.goodId;
			   //如果有相同商品行存在则只作数量追加
			   if(!parameter.notCover && $('.goods-clone').find('#'+goodId).length>0){
	   				var nums = $($('.goods-clone').find('#'+goodId)[0]).parent().parent().parent().next().children()[0];
	   				nums.value = parseInt(nums.value) + parseInt(orderNum);
	   				parameter.isNumChange && numChange(nums,nums.id.substring(3));
	   				toastr['success']("选择相同商品，数量叠加！", "");
	   				nums.style.border = '5px solid #458567';
	   				setTimeout(function(){nums.style.border = '1px solid #e5e5e5'},100);
	   				return;
	   			}
			   
			   var type = 'hidden';
			   var view = 'none';
			   var src = hasObj.coverUrl?parameter.domainUrl+hasObj.coverUrl:'images/spec.png';
			   //如果商品有多个规格的处理
			   if(hasObj.goodSpecValueVO.length>0) {
				   var specName = '';
				   for(var i=0;i<hasObj.goodSpecValueVO.length;i++) {
					   specName += (i==0?'【':'')+hasObj.goodSpecValueVO[i].specVO.specName+':'+hasObj.goodSpecValueVO[i].specValueVO.specValue+(i==hasObj.goodSpecValueVO.length-1?'】':',');
				   }
				
				    var cloneHtml = '<div unitName="'+ hasObj.unitName +'" data-toggle="tooltip"  data-html="true" title="'+hasObj.goodsCode+' '+hasObj.goodsName+' '+specName+'" class="_item-clone" id="'+hasObj.goodId+'"><span class="goods-pic"><img src="'+src+'"/></span><span class="goods-info">'+hasObj.goodsCode+' '+hasObj.goodsName+' '+specName+'</span></div>';
			   }
			   else{
					var cloneHtml = '<div unitName="'+ hasObj.unitName +'" data-toggle="tooltip"  data-html="true" title="'+hasObj.goodsCode+' '+hasObj.goodsName+'" class="_item-clone" id="'+hasObj.goodId+'"><span class="goods-pic"><img src="'+src+'"/></span><span class="goods-info">'+hasObj.goodsCode+' '+hasObj.goodsName+'</span></div>';
			   }
		   }
		   else{
			   //新增空白行预处理
			   var goodId = '';
			   var type = 'text';
			   var view = 'block';
			   var cloneHtml = '';
		   }
		   
		   var ran = Math.floor(Math.random()*1000);
		   var  tr = "<tr id='tr_" + ran + "'>"
           				+ "<td class='select-goods-area'>"
       						+ "<div style='position:relative'>"
       							+ "<input type='"+type+"' name='goodId' value='"+goodId+"'/>"
       							+ "<div class='_goods-list'>"
										+ "<div class='_item'><span>暂无数据.</span></div>"
									+ "</div>"
									+ "<div class='goods-clone'>"
										+cloneHtml
									+ "</div>"
									+ "<span class='glyphicon glyphicon-list show-goods' style='display:"+view+"'></span>"
								+ "</div>"
							+ "</td>"
       				+ parameter.insertTd//插入的td
   					+ "<td>"
   						+ "<button type='button' class='btn' onclick='del_tr("+ ran +")' class='col-md-3 control-label'><i class='fa fa-times'></i>&nbsp;&nbsp;删除</button>"
   					+ "</td>"
  				 + "</tr>";
		   $("#"+parameter.tbodyId).append(tr);
		   if(hasObj != 'isAdd') {
			   var _tr = $("#"+parameter.tbodyId).children()[$("#"+parameter.tbodyId).children().length-1]
			   if(parameter.notGetGoodsInfo && parameter.orderNumIn === undefined){
				   var td = _tr.children;
				   td[4].children[0].value = orderNum;
			   }
			   else if(parameter.orderNumIn){
				   var td = _tr.children;
				   td[parameter.orderNumIn].children[0].value = orderNum;
			   }
			   if(parameter.goodsChangeHandler != undefined){
		   			//商品选择发生改变的回调( 传入当前行 tr )
			   		parameter.goodsChangeHandler(_tr,orderNum,hasObj.goodId,null,hasObj.selectedUnitVal);
		   		}
			   getGoodsInfo($("#"+parameter.tbodyId).children()[$("#"+parameter.tbodyId).children().length-1],goodId,'addAll',orderNum,priceo,hasObj.selectedUnitVal);
			   
			   if(parameter.getGoodsSpecInfo){
				   	var divObj = $($("#"+parameter.tbodyId).children()[$("#"+parameter.tbodyId).children().length-1]).find('div[style="position:relative"]')[0];
		   			var storeId1 = $('#storeId').val();
		   			getGoodsSpecInfo(divObj,goodId,storeId1,orderNum);
		   		}
			   
		   }
		   goodsInputFocus();
		   showGoodsListBtn();
		   viewedItemClick();
		   goDowmGoodsList();
	   }
	   $("#addList").click(function() {
		   //添加空白行的点击事件
		   addTr('isAdd');
	   });
		   
		   //2016-12-14 16:57
		   getGoodsList('load');//发起第一次初始化数据请求
		   /**
		   	getGoodsList: 请求商品列表数据
		   		@param loadAgr 必须，load为下拉滚动翻页事件. number类型则是页码翻页加载事件
		    */
			function getGoodsList(loadAgr, dataValue) {
				var data;
			   if(loadAgr == 'load') {
				   currentPage++;
				   data = {currentPage: currentPage, pageSize: pageSize}
			   }
			   if(typeof(loadAgr) == 'number') {
				   data = {currentPage: loadAgr, pageSize: pageSize}
			   }
			   
			   if(dataValue != undefined) {
				   
				   data = {currentPage: loadAgr, pageSize: pageSize, goodSearch: dataValue}
			   }
			   if(parameter.sytState == "Y"){
				   var a = $.ajax({
					   type: 'POST',
					   data: data,
					   url: parameter.requestUrl?parameter.requestUrl:'${contextPath}'.substring(0,'${contextPath}'.indexOf('/',-1))+"getGoodsSpecSyt",
					   success: function(result){
						  if(result.result == 'OK') {
							  if(loadAgr == 'load') {
							  	goodsListData = goodsListData.concat(result.goodsList);
							  	layoutGoods();
							  }
							  if(typeof(loadAgr) == 'number') {
								pageGoodsList = result.goodsList;
							  }	
								pageCount = result.pageCount;
								recordCount = result.recordCount;
						  }
						},
					    dataType: 'json',
					    async: false
					});
			   }else if(parameter.sytState == "N"){
				   var a = $.ajax({
					   type: 'POST',
					   data: data,
					   url: parameter.requestUrl?parameter.requestUrl:'${contextPath}'.substring(0,'${contextPath}'.indexOf('/',-1))+"getGoodsSpec",
					   success: function(result){
						  if(result.result == 'OK') {
							  if(loadAgr == 'load') {
							  	goodsListData = goodsListData.concat(result.goodsList);
							  	layoutGoods();
							  }
							  if(typeof(loadAgr) == 'number') {
								pageGoodsList = result.goodsList;
							  }	
								pageCount = result.pageCount;
								recordCount = result.recordCount;
						  }
						},
					    dataType: 'json',
					    async: false
					});
			   }else{
				   var a = $.ajax({
					   type: 'POST',
					   data: data,
					   url: parameter.requestUrl?parameter.requestUrl:'${contextPath}'.substring(0,'${contextPath}'.indexOf('/',-1))+"getGoodsSpecAll",
					   success: function(result){
						  if(result.result == 'OK') {
							  if(loadAgr == 'load') {
							  	goodsListData = goodsListData.concat(result.goodsList);
							  	layoutGoods();
							  }
							  if(typeof(loadAgr) == 'number') {
								pageGoodsList = result.goodsList;
							  }	
								pageCount = result.pageCount;
								recordCount = result.recordCount;
						  }
						},
					    dataType: 'json',
					    async: false
					});
			   }
				
		   	}
	   		
			/**
		   	goodsInputFocus: 下拉input的focus事件
		   		@param null
		    */
			$('input[name="goodId"]').live('focus',function() {
				if(focusInput != undefined && focusInput.type == 'hidden') {
					   $(focusInput).next().next().show();
				   }
				   focusInput = this;
				   this.style.borderColor = '#999999';
				   $('._goods-list').hide();
				   //map商品列表数据，layout商品列表
				   layoutGoods();
			});
		   function goodsInputFocus() {
			   /*$('input[name="goodId"]').unbind('focus');
			   $('input[name="goodId"]').bind('focus',function(){
				   if(focusInput != undefined && focusInput.type == 'hidden') {
					   $(focusInput).next().next().show();
				   }
				   focusInput = this;
				   this.style.borderColor = '#999999';
				   $('._goods-list').hide();
				   //map商品列表数据，layout商品列表
				   layoutGoods();
			   });*/
		   }
		   goodsInputFocus();//初始化focus事件
		   
		   function layoutGoods() {
			   var goodsListHtml = '';
			   goodsListData.map(function(item) {
				   var src = item.coverUrl?parameter.domainUrl+item.coverUrl:'images/spec.png';
				   if(item.goodSpecValueVO.length>0) {
					   var specName = '';
					   for(var i=0;i<item.goodSpecValueVO.length;i++) {
						   specName += (i==0?'【':'')+item.goodSpecValueVO[i].specVO.specName+':'+item.goodSpecValueVO[i].specValueVO.specValue+(i==item.goodSpecValueVO.length-1?'】':',');
					   }
					
					    goodsListHtml += '<div unitName="'+ item.unitName +'" data-toggle="tooltip"  data-html="true" title="'+item.goodsCode+' '+item.goodsName+' '+specName+'" class="_item" id="'+item.goodId+'"><span class="goods-pic"><img src="'+src+'"/></span><span class="goods-info">'+item.goodsCode+' '+item.goodsName+' '+specName+'</span></div>';
				   }
				   else{
						goodsListHtml += '<div unitName="'+ item.unitName +'" data-toggle="tooltip"  data-html="true" title="'+item.goodsCode+' '+item.goodsName+'" class="_item" id="'+item.goodId+'"><span class="goods-pic"><img src="'+src+'"/></span><span class="goods-info">'+item.goodsCode+' '+item.goodsName+'</span></div>';
				   }
				   
			   });
			   $(focusInput).next().html(goodsListHtml);
			   //显示商品列表
			   $(focusInput).next().show();
			   //商品列表宽度与输入宽一致
				goodsWidth = $('.select-goods-area').width();
				$('._item').css('width',goodsWidth-20);
				//激活绑定事件
				goodsListItemClick();
				viewedItemClick();
				goDowmGoodsList();
		   }
		   //下拉滚动翻页
		   /*$('._goods-list').on('scroll', function() {
			   	var h = $(this).height();
	   			var sh = $(this)[0].scrollHeight;
	   			var st = $(this)[0].scrollTop;
	   			if(h+st >= sh) {
	   				$('._goods-list').unbind('scroll');
	   				if(pageCount != 0 && currentPage == pageCount) {return $('._goods-list').append('<div class="goods-list-load">已加载全部...</div>')}
	   				$('._goods-list').append('<div class="goods-list-load">正在加载更多商品...</div>');
	   				getGoodsList('load');
	   			}
		   });*/
		   function goDowmGoodsList() {
		   		/*$('._goods-list').unbind('scroll');
		   		$('._goods-list').bind('scroll', function() {
		   			var h = $(this).height();
		   			var sh = $(this)[0].scrollHeight;
		   			var st = $(this)[0].scrollTop;
		   			if(h+st >= sh) {
		   				$('._goods-list').unbind('scroll');
		   				if(pageCount != 0 && currentPage == pageCount) {return $('._goods-list').append('<div class="goods-list-load">已加载全部...</div>')}
		   				$('._goods-list').append('<div class="goods-list-load">正在加载更多商品...</div>');
		   				getGoodsList('load');
		   			}
		   		});*/
			   $('._goods-list').on('scroll', function() {
				   	var h = $(this).height();
		   			var sh = $(this)[0].scrollHeight;
		   			var st = $(this)[0].scrollTop;
		   			if(h+st >= sh) {
		   				$('._goods-list').unbind('scroll');
		   				if(pageCount != 0 && currentPage == pageCount) {return $('._goods-list').append('<div class="goods-list-load">已加载全部...</div>')}
		   				$('._goods-list').append('<div class="goods-list-load">正在加载更多商品...</div>');
		   				getGoodsList('load');
		   			}
			   });
		   }
		   
		   /**
		   	goodsListItemClick: 下拉商品列表的列点击事件
		   		@param null
		    */
		   function goodsListItemClick() {
			   $('._item').unbind('click');
			   $('._item').bind('click', function() {
			   		var goods = this;
			   		goods.className = '_item-clone';
			   		$('._item-clone').width(goodsWidth[0]);
			   		$(this).parent().hide();
			   		$(this).parent().parent().parent().find('.goods-clone').html(goods);
			   		$(this).parent().parent().parent().find('.goods-clone').show();
			   		focusInput.type = 'hidden';
			   		focusInput.value = this.id;
			   		$(focusInput).parent().find('.show-goods').hide();
			   		if(!parameter.notCover && $('.goods-clone').find('#'+this.id)[0] != undefined){
			   			if($('.goods-clone').find('#'+this.id).length>1){
			   				var n = $(this).parent().parent().parent().parent()[0].id;
			   				var nums = $($('.goods-clone').find('#'+this.id)[0]).parent().parent().parent().next().children()[0];
			   				nums.value++;
			   				parameter.isNumChange && numChange(nums,nums.id.substring(3));
			   				toastr['success']("选择相同商品，数量叠加！", "");
			   				nums.style.border = '5px solid #458567';
			   				setTimeout(function(){nums.style.border = '1px solid #e5e5e5'},100);
			   				$("#"+n).remove();
			   				$("."+n).remove();
			   				return;
			   			}
			   		}
			   		//获取商品信息, 刷新单位、单价、订货价、小计和合计
			   		getGoodsInfo(this.parentNode.parentNode,this.id);
			   		//获取商品批次号信息列表
			   		if(parameter.getGoodsSpecInfo){
			   			var storeId1 = $('#storeId').val();
			   			getGoodsSpecInfo(this.parentNode.parentNode,this.id,storeId1);
			   		}
			   		if(parameter.goodsChangeHandler != undefined){
			   			//商品选择发生改变的回调( 传入当前行 tr )
				   		parameter.goodsChangeHandler(this.parentNode.parentNode.parentNode.parentNode,null,this.id);
			   		}
			   		if(parameter.goodsChooseHandler != undefined){
				   		parameter.goodsChooseHandler(this.parentNode.parentNode.parentNode,this.id);
			   		}
			   		
			   });
		   }
		   
		   /**
		   	viewedItemClick: table第一格显示的商品的点击事件, 点击将隐藏当前商品并展示下拉商品列表
		   		@param null
		    */
		   /*$('.goods-clone').on('click',function() {
			   var txtVal = $(this).find('.goods-info').text();
			   $(this).hide();
			   $(this).parent().find('input[name="goodId"]')[0].value = txtVal;
			   $(this).parent().find('input[name="goodId"]')[0].type = 'text';
			   $(this).parent().find('input[name="goodId"]').focus();
			   $(this).parent().find('.show-goods').show();
		   });*/
		   function viewedItemClick() {
			   $('.goods-clone').on('click',function() {
				   var txtVal = $(this).find('.goods-info').text();
				   $(this).hide();
				   $(this).parent().find('input[name="goodId"]')[0].value = txtVal;
				   $(this).parent().find('input[name="goodId"]')[0].type = 'text';
				   $(this).parent().find('input[name="goodId"]').focus();
				   $(this).parent().find('.show-goods').show();
			   });
			   /*$('.goods-clone').unbind('click');
			   $('.goods-clone').bind('click', function() {
				   var txtVal = $(this).find('.goods-info').text();
				   $(this).hide();
				   $(this).parent().find('input[name="goodId"]')[0].value = txtVal;
				   $(this).parent().find('input[name="goodId"]')[0].type = 'text';
				   $(this).parent().find('input[name="goodId"]').focus();
				   $(this).parent().find('.show-goods').show();
			   });*/
		   }
		   viewedItemClick();//初始化
		   
		   /**
		   	showGoodsListBtn: 显示模态框的开关, 显示并发起第一次模态框中的商品列表数据请求
		   		@param null
		    */
		   $('.show-goods').live('click',function() {
			   showGoodsListModalBtn = this;
			   $('._goods-list').hide();
			   getGoodsList(1);
			   addModalTr(pageGoodsList);
			   $('#chooseGoods').modal();
		   })
		   function showGoodsListBtn() {
			   /*$('.show-goods').click(function() {
				   showGoodsListModalBtn = this;
				   $('._goods-list').hide();
				   getGoodsList(1);
				   addModalTr(pageGoodsList);
				   $('#chooseGoods').modal();
			   });*/
		   }
		   showGoodsListBtn();//初始化
		   
		   /**
		   	addModalTr: 模态框的动态生成行函数
		   		@param par 参数是当前页的数据
		    */
		   function addModalTr(par,str) {
			   if(str != 'needNum' && !parameter.notNeedNum){
				   nextNum = $(showGoodsListModalBtn).parent().parent().next().children()[0].value;//获取数量
			   }
			   else{
				   nextNum = '';
			   }
			   if(parameter.needSendCompanyId){
				   newGoodsName = $(showGoodsListModalBtn).parent().parent().parent().find('input[name="goodsNames"]').val();//获取商品名称
				   newCompanyId = $(showGoodsListModalBtn).parent().parent().parent().find('input[name="companyId"]').val();//获取公司ID
				   $('#chooseGoods .search-group .newGoodsName').val(newGoodsName);
				   $('#chooseGoods .search-group .newCompanyId').val(newCompanyId);
				   //parameter.needSendCompanyId = false;
			   }
			   if(nextNum == '') nextNum = 0;
			   	
				   $("#goodslist-tbody").empty();
				   par.map(function(item,index) {
					   var checkeds = '';
					   var checkedNum = 0;
					   var data_ = '';
					   var selectedUnitVal = null;
					   if(str != 'needNum'){
					   for(var i=0; i<checkedGoodsArr.length;i++) {
						   if(checkedGoodsArr[i].goodId == item.goodId){
							  	checkeds = 'checked="checked"';
						   		checkedNum = checkedGoodsArr[i].orderCount;
						   		data_ = 'data-number='+item.goodId;
						   		if(checkedGoodsArr[i].selectedUnitVal){
						   			selectedUnitVal = checkedGoodsArr[i].selectedUnitVal;
						   		}
						   }   
					   }
					   }
					   if(parameter.modalGetUnit){
						   parameter.insertModalTd = "<td><div class='form-control'>"+item.unitName+"</div></td>"
					   }
					 	var src = item.coverUrl?parameter.domainUrl+item.coverUrl:'images/spec.png';
					 	var goodsName = item.goodsName;
					 	if(item.goodSpecValueVO.length>0) {
							   var specName = '';
							   for(var i=0;i<item.goodSpecValueVO.length;i++) {
								   specName += (i==0?'【':'')+item.goodSpecValueVO[i].specVO.specName+':'+item.goodSpecValueVO[i].specValueVO.specValue+(i==item.goodSpecValueVO.length-1?'】':',');
							   }
							   goodsName += specName;
					 	}
					 	var storageNumStr = parameter.needStorageNum?"<td><input type='text' value='"+checkedNum+"' name='orderNum' "+data_+" class='form-control' /></td>":"";
					 	var _cBox = parameter.isRadio?'radio':'checkbox';
					   	var  _tr = "<tr>"
	          				+ "<td><input id='checkbox"+index+"' type="+_cBox+" name='checkedGoods' value='"+item.goodId+"' "+checkeds+"></td>"
	          				+ "<td><img src='"+src+"'></td>"
	          				+ "<td>"+item.goodsCode+"</td>"
	          				+ "<td><label for='checkbox"+index+"'>"+goodsName+"</label></td>"
      						+ parameter.insertModalTd
      						+ storageNumStr
 				 			+ "</tr>";
		   				$("#goodslist-tbody").append(_tr);
		   				var obj = $("#goodslist-tbody").children()[index];
		   				
		   				getGoodsInfo(obj, item.goodId, 'agr',null,null,selectedUnitVal);
		   				if(parameter.startUsingMoreNuit){
		   					parameter.goodsChangeHandler(obj,null,item.goodId,'modal',selectedUnitVal);
		   				}
				   });
				   $('#pagination-info').html('共有  '+ pageCount +' 页 | 合计 '+ recordCount +' 条记录');
			   checkedGoods();
		   }
		   
		   /**
		   	checkedGoods: 模态框中的checkBox的选中事件, 选中则把选中商品的源数据项添加到checkedGoodsArr队列,
		   				      同时为其相应的下单数量input添加自定义属性以便获取下单数量
		   				      选中后又取消选中则从checkedGoodsArr队列中删除相应的数据,
		   		@param null
		    */
		   function checkedGoods() {
			   $('input[name="checkedGoods"]').change(function() {
				   if(parameter.isRadio){
						   if($(this).is(':checked')){
							   for(var i=0;i<pageGoodsList.length; i++){
								   if(pageGoodsList[i].goodId == this.value){
									   checkedGoodsArr[0] = pageGoodsList[i];
									   break;
								   };
							   }
						   }
				   }
				   else{
					   if(!$(this).is(':checked')){
						   for(var i=0;i<checkedGoodsArr.length;i++) {
							   if(checkedGoodsArr[i].goodId == this.value){
								   checkedGoodsArr.splice(i,1);
							   }
						   }
						   
						   $(this).parent().parent().find('input[name="orderNum"]').val(0);
						   $(this).parent().parent().find('input[name="orderNum"]').removeAttr('data-number');
						   $(this).parent().parent().find('input[name="orderPrice"]').removeAttr('data-priceo');
					   }
					   else {
						   $(this).parent().parent().find('input[name="orderNum"]').val(1);
						   var selectedUnit = $(this).parent().parent().find('select[id]').val();
						   $(this).parent().parent().find('input[name="orderNum"]').attr('data-number',this.value);
						   $(this).parent().parent().find('input[name="orderPrice"]').attr('data-priceo',this.value);
						   for(var i=0;i<pageGoodsList.length; i++){
							   if(pageGoodsList[i].goodId == this.value){
								   pageGoodsList[i].orderCount = 1;
								   checkedGoodsArr.push(pageGoodsList[i]);
							   };
						   }
					   }
				   }
			   });
		   }
		   
		   //下单数量的失焦事件, 将下单数量添加到相应商品的队列项中存为orderCount
			$('input[data-number]').live('blur',function() {
				   for(var i=0;i<checkedGoodsArr.length;i++) {
						if(checkedGoodsArr[i].goodId == $(this).attr('data-number')){
							checkedGoodsArr[i].orderCount = parseInt($(this).val());
						}
					}

			});
			//模态框单位改变事件, 将单位value添加到相应商品的队列项中存为selectedUnitVal
			$('select[data-selectUnit]').live('change',function() {
				   for(var i=0;i<checkedGoodsArr.length;i++) {
						if(checkedGoodsArr[i].goodId == $(this).attr('data-selectUnit')){
							checkedGoodsArr[i].selectedUnitVal = $(this).val();
						}
					}
			});
			//订货价的失焦事件, 将下单数量添加到相应商品的队列项中存为orderCount
			$('input[data-priceo]').live('blur',function() {
				   for(var i=0;i<checkedGoodsArr.length;i++) {
						if(checkedGoodsArr[i].goodId == $(this).attr('data-priceo')){
							checkedGoodsArr[i].orderPriceo = parseInt($(this).val());
						}
					}

			});
		   
		   $('#pageUp').bind('click',jumpPage);//模态框中, 上一页
		   $('#pageDown').bind('click',jumpPage);//模态框中, 下一页
		   $('#currentPage').live('change',goPage);//模态框中, 页码改变
		   
		   function jumpPage() {
			   var num1 = $('#currentPage').val();
			   this.id == 'pageUp' ? num1-- : num1++;
			   if(num1 == 0) num1 = 1;
			   if(num1 > pageCount) num1 = pageCount;
			   $('#currentPage').val(num1);
			   var hasValue = $('#chooseGoods .search-group>input').val();
			   if(hasValue == '' || hasValue == null){
				   getGoodsList(num1);
			   }
			   else{
				   getGoodsList(num1,hasValue);
			   }
			   addModalTr(pageGoodsList);
		   }
		   function goPage() {
			   if(parseInt(this.value) > pageCount){
				   return toastr['error']('输入页码过大，请重新输入！', "");
			   }
			   if(parseInt(this.value) <= 0){
				   return toastr['error']('输入页码不能小于 0 ！', "");
			   }
			   if(parseInt(this.value)*0 != 0){
				   return toastr['error']('请输入数字页码 ！', "");
			   }
			   var hasValue = $('#chooseGoods .search-group>input').val();
			   if(hasValue == '' || hasValue == null){
				   getGoodsList(parseInt(this.value));
			   }
			   else{
				   getGoodsList(parseInt(this.value), hasValue);
			   }
			   addModalTr(pageGoodsList);
		   }
		   
		   //模态框确认点击事件
		   $('#comfirm-choose-goods').click(function() {
			   if(checkedGoodsArr.length <= 0){
				   return toastr['error']('请至少选择一个商品 ！', "");
			   }
			   var trId = $(showGoodsListModalBtn).parent().parent().parent();
			   if(parameter.isRadio){
				   trId.find('input[name="goodId"]')[0].type = 'hidden';
				   trId.find('input[name="goodId"]').val(checkedGoodsArr[0].goodId);
				   trId.find('.show-goods').hide();
				   //如果商品有多个规格的处理
				   var src = checkedGoodsArr[0].coverUrl?parameter.domainUrl+checkedGoodsArr[0].coverUrl:'images/spec.png';
				   if(checkedGoodsArr[0].goodSpecValueVO.length>0) {
					   var specName = '';
					   for(var i=0;i<checkedGoodsArr[0].goodSpecValueVO.length;i++) {
						   specName += (i==0?'【':'')+checkedGoodsArr[0].goodSpecValueVO[i].specVO.specName+':'+checkedGoodsArr[0].goodSpecValueVO[i].specValueVO.specValue+(i==checkedGoodsArr[0].goodSpecValueVO.length-1?'】':',');
					   }
					    var cloneHtml = '<div unitName="'+ checkedGoodsArr[0].unitName +'" data-toggle="tooltip"  data-html="true" title="'+checkedGoodsArr[0].goodsCode+' '+checkedGoodsArr[0].goodsName+' '+specName+'" class="_item-clone" id="'+checkedGoodsArr[0].goodId+'"><span class="goods-pic"><img src="'+src+'"/></span><span class="goods-info">'+checkedGoodsArr[0].goodsCode+' '+checkedGoodsArr[0].goodsName+' '+specName+'</span></div>';
				   }
				   else{
						var cloneHtml = '<div unitName="'+ checkedGoodsArr[0].unitName +'" data-toggle="tooltip"  data-html="true" title="'+checkedGoodsArr[0].goodsCode+' '+checkedGoodsArr[0].goodsName+'" class="_item-clone" id="'+checkedGoodsArr[0].goodId+'"><span class="goods-pic"><img src="'+src+'"/></span><span class="goods-info">'+checkedGoodsArr[0].goodsCode+' '+checkedGoodsArr[0].goodsName+'</span></div>';
				   }
				   trId.find('.goods-clone').html(cloneHtml);
				   trId.find('.goods-clone').show();
			   }
			   else{
			   if(checkedGoodsArr.length>0){
				   del_tr(trId[0].id.substring(3),'canDel');
			   }
			   checkedGoodsArr.map(function(item,index) {
				   //////console.log(item,item.orderCount,item.orderPriceo);
				   addTr(item,item.orderCount,item.orderPriceo);//把被选中的所有商品的源数据项和当前项的订单数量传递&订货价
			   });
			   }
			   if(parameter.goodsChooseHandler != undefined){
			   		parameter.goodsChooseHandler($(showGoodsListModalBtn).parent().parent(),checkedGoodsArr[0].goodId);
		   		}
			   $('#chooseGoods').modal('hide');
			   //以下,初始化所有的在模态框的表格内容
			   checkedGoodsArr = [];
			   $('#goodslist-tbody').find('input[name="orderNum"]').val(0);
			   $('#goodslist-tbody').find('input[data-number]').removeAttr('data-number');
			   $('#goodslist-tbody input[type="checkbox"]').attr('checked',false);
			   $('#currentPage').val(1);
		   });
		   
		   //搜索
		   $('.search-goods-btn').click(function() {
			   var value = $(this).prev().val();
			   getGoodsList(1, value);
			   addModalTr(pageGoodsList);
			   $('#pagination-info').html('共有  '+ pageCount +' 页 | 合计 '+ recordCount +' 条记录');
		   });
		   
		   
		   
		   
	}