var curPage=1,//当前页
    pageCount=0,//总页数
	schTable=$("#schTable"),
	gridArr=[],//表格位置区间,[(X1,X2,Y1,Y2)];
	endPosX=endPosY=0,//记录拖曳鼠标最后的坐标
	targetMany=0,//弹框前,计算格子内有几个标签
	targetUnit=null,//当前格内标签的单位
	target_tbLbIndex=0,//点击当前格内第几个标签
	target_tbLb_Top=0,//当前格内第几个标签距离
	colorList = [
		'#f46e65', //红色
		'#3dbd7d', //绿色
		'#49a9ee', //蓝色
		'#f7629e', //粉色
		'#f78e3d', //橙色
		'#948aec', // 浅蓝
		'#ffce3d', //黄色
		'#3db8c1', //青色
		'#87B5D9', //设计色
	]
	actionObj={
		getAllOperate:"getAllOperate",//生成计划
		queryStandardItem:"queryStandardItem",//查询计划细项列表
		saveStandardItem:"saveStandardItem",//编辑或保存计划细项元素
		delStandardItem:"delStandardItem",//删除计划细项
		createStandardTable:"createStandardTable"//新建计划  生成计划
    },
	colorObj = new Object();
 
$(function(){
	var breedDays=$("#breedDaysTotal").val();
	if(istable=='Y'){//计划编辑页面
		getLabelList();
		ajaxData_Table(curPage);
		if(curPage!==pageCount){//有分页才展示加载更多
			$("#loadingMore").css("display","block");
		}
	}
	
	$("#loadingMore a").click(function(){
		curPage++;
		if(curPage==pageCount){$(this).slideUp();}
		if(curPage>pageCount){return;}
		ajaxData_Table(curPage);	
		floatLabel();//关联操作板块悬浮,表格变化重新计算
	});
	
	$("#lucidPop").bind("click",function(){//弹框透明遮罩层
		//alert("请完成弹框内的操作");
		$(this).fadeOut();
		$(".tbLb").fadeOut();
	});
	$(".ensure").live("click",function(){//数量弹框 确定按钮
      var newNumber=$(this).siblings(".numIpt").val();
      var _this=this;
      
      if(newNumber!==''){
    	  if(!isNaN(newNumber) && !/^\d+(\.\d+)?$ /.test(newNumber)){
			$(_this).closest("li").find(".tableLabel").eq(target_tbLbIndex).find("font").html(newNumber);
			$(_this).siblings(".numIpt").val('');
			$(_this).closest(".tbLb").css("display","none");
			$(".tableLabelOper,#lucidPop").fadeOut(200);
			
			$title=$(_this).closest("li").find(".tableLabel").eq(target_tbLbIndex).find("span").html()+' '+newNumber+$(_this).closest("li").find(".tableLabel").eq(target_tbLbIndex).find("i").html();
			$(_this).closest("li").find(".tableLabel").eq(target_tbLbIndex).attr("title",$title);
			
    		  
			var days=$(_this).closest("li").find(".day_number").html();
			var operateId=$(_this).closest("li").find(".tableLabel").eq(target_tbLbIndex).attr("operid");
			var subitemid=$(_this).closest("li").find(".tableLabel").eq(target_tbLbIndex).attr("subitemid");
			
			console.log("subitemid=="+subitemid);

			$.ajax({
			   url:actionObj.saveStandardItem,
			   type:"post",
			   dataType:"json",
			   data:{standardId:standardId,days:days,operateId:operateId,amount:newNumber,id:subitemid?subitemid:''},
			   success:function(result){
				 if(result.result=='OK'){
					 $(_this).closest("li").find(".tableLabel").eq(target_tbLbIndex).attr("subitemId",result.standardItemId);
					 toastr['success']("保存成功", "");
				 }else{
					 toastr['error'](result.msg, "");
				 }
			   }
			})	;
    	  }else{
    		  $(this).siblings(".numIpt").val('');
    		  alert("单位只能输入数字,请重新输入");
    	  }
      }else{
    	  alert("请先输入数量");
      }
	});
	
	
    $(".tableLabel").live("click",function(){
		target_tbLbIndex=$(this).index()-3,//当前点击表格内的哪个标签
		console.log(target_tbLbIndex);
		target_tbLb_Top=target_tbLbIndex*24-80;//24为标签与上边距之和,-80为距离第一个标签的起始位
		$(this).closest("li").find(".tbLbOper").attr("style","top:"+target_tbLb_Top+"px").fadeIn(50);
		$(this).closest("li").find(".tbLbNum .numIpt").focus();
		$("#lucidPop").fadeIn();
	});
	
	$(".editLable").live("click",function(){//操作弹框 编辑标签
		$(".tbLbOper").fadeOut();
		$(this).closest("li").find(".tbLbNum").attr("style","top:"+target_tbLb_Top+"px").fadeIn();
		$(this).closest("li").find(".tbLbNum .numIpt").focus();
	});
	
	$(".deleteLable").live("click",function(){//操作弹框 删除标签
		$("#lucidPop,.tbLbOper").fadeOut();
		var target_tableLabel=$(this).closest("li").find(".tableLabel").eq(target_tbLbIndex),
			   subitemid=target_tableLabel.attr("subitemid");
		$.ajax({
		   url:actionObj.delStandardItem,
		   type:"post",
		   dataType:"json",
		   data:{id:subitemid},
		   success:function(result){
			 if(result.result=='OK'){
				 target_tableLabel.remove();
				 $("#schTable ul li").attr("style","");
				 adapteLi();
				 toastr['success'](result.msg, "");
			 }
			 else{
				 toastr['error'](result.msg, "");
			 }
		   }
		});
	});
});


//新增页面 生成计划
function create_scheme(){
	breedDays=$("#breedDaysTotal").val();
	if(breedDays==''){alert("请先选择品类，然后在生成计划");return;}
	
	if(istable=='Y'){//已经创建计划并存到数据库
		$("#categoryNameShow").attr("disabled","true").attr("onclick","");
		getLabelList();
		creatTable(breedDays);
	}else{
		var createObj={};
		createObj.id=hashurl.split("=")[1];
		createObj.standardName=$("input[name='standardName']").val();
		createObj.description=$("textarea[name='description']").val();
		createObj.categoryId=$("#categoryId").val();
		createObj.categoryName=$("#categoryName").val();
		createObj.isvalid='N';
		$.ajax({
		   url:actionObj.createStandardTable,
		   type:"post",
		   dataType:"json",
		   data:createObj,
		   success:function(result){
			if(result.standardVO.isCreateTable=="Y"){
				$("#categoryNameShow").attr("disabled","true").attr("onclick","");
				$("#isCreateTable").val("Y");
				getLabelList();
				creatTable(breedDays);
			}
		  }   
		});
	}
}

//新增页面 创建养殖计划表格
function creatTable(breedDays){
	for(var i=0,newEle='',newNum=0;i<breedDays;i++){
		newNum++;
		newEle+='<li><div class="day_number">'+newNum+'</div>';
		newEle+='<div class="tbLb tbLbNum"><h2>请输入数量：</h2><p><input type="text" class="numIpt"/><b class="ensure"><i></i></b></p><span><i></i></span></div> ';
		newEle+='<div  class="tbLb tbLbOper"><h2>你要进行的操作是：</h2><p><a href="javascript:" class="editLable">编辑</a><a href="javascript:" class="deleteLable">删除</a></p><span><i></i></span></div>';
		newEle+='</li>';
	}
	schTable.closest("#scheme").slideDown();
	schTable.find("ul").append(newEle);
	floatLabel();//关联操作板块悬浮,表格变化重新计算
	gridArrOn();//生成格子后,重新计算格子区间
	adapteLi();
}

//关联操作板块悬浮
function floatLabel(){
	var scheme_offsetT=$("#scheme").offset().top,scheme_offsetL=$("#scheme").offset().left;
	$(window).scroll(function(){
		var scrollTop=$(window).scrollTop();
		if(scrollTop>=scheme_offsetT){
			$(".sch_label").attr("style","position:fixed;top:0;left:125px;");
		}else{
			$(".sch_label").removeAttr("style");
		}
	});
}

//编辑页面 查询并生成计划表格,加载格子内的操作标签
function ajaxData_Table(currentPage){
	$.ajax({
	   url:actionObj.queryStandardItem,
	   type:"post",
	   dataType:"json",
	   data:{id:hashurl.split("=")[1],currentPage:currentPage},
	   success:function(result){
		  pageCount=result.pageCount;
		  var ele='',itemList=result.itemList;
		  if(!itemList){return;}
		  for(key in itemList){
			ele+='<li><div class="day_number">'+strZero(key)+'</div>';
			ele+='<div class="tbLb tbLbNum"><h2>请输入数量：</h2><p><input type="text" class="numIpt"/><b class="ensure"><i></i></b></p><span><i></i></span></div> ';
			ele+='<div  class="tbLb tbLbOper"><h2>你要进行的操作是：</h2><p><a href="javascript:" class="editLable">编辑</a><a href="javascript:" class="deleteLable">删除</a></p><span><i></i></span></div>';
			if(itemList[key]&&itemList[key].length>0){
	            for(val in itemList[key]){
					if(!itemList[key][val].color||itemList[key][val].color==''){itemList[key][val].color='3A87AD';}//如果没配颜色,取默认颜色--background:#'+itemList[key][val].color+';
					ele+='<div class="tableLabel" subitemId="'+itemList[key][val].id+'" operid="'+itemList[key][val].operateId+'" style="background:'+colorObj[itemList[key][val].operateId]+';color:#fff;" title="'+itemList[key][val].operateName+'  '+(itemList[key][val].amount?itemList[key][val].amount+itemList[key][val].spec:"")+'"><span>'+itemList[key][val].operateName+'</span><font>'+(itemList[key][val].amount?itemList[key][val].amount:"")+'</font><i>'+(itemList[key][val].amount?itemList[key][val].spec:"")+'</i></div>';
				}
			}
			ele+='</li>';
		  }
		  applyTabColor();//渲染标签颜色
		  schTable.find("ul").append(ele);
		  gridArrOn();//生成格子后,重新计算格子区间
		  adapteLi();
	   }   
	});
}

//获取标签 操作列表
function getLabelList(){
	$.ajax({
	   url:actionObj.getAllOperate,
	   type:"post",
	   dataType:"json",
	   success:function(result){
		   var items=result.operateList;
		   for(var i=0,ite='';i<items.length;i++){
			   //if(!items[i].color||items[i].color==''){items[i].color='3A87AD';}//如果没配颜色,取默认颜色
			   items[i].colorStr = colorList[i]?colorList[i]:'#0EA3CA';
			   //$('div[operid="'+items[i].id+'"]').css('background',items[i].colorStr);
			   ite+='<div class="external-event event_label" unit="'+items[i].spec+'" bgcolor="'+items[i].colorStr+'" operateId="'+items[i].id+'">'+items[i].operateName+'</div><div class="emptyLine"></div>';
			   setBgColor('',items[i].id,i);
		   }
		   $("#event-box").empty().append(ite);
		   dragDrop();
		   $(".external-event").each(function(e){
				$(this).css({"background":""+$(this).attr("bgcolor"),"color":"#fff"});
		   });
		   //applyTabColor();//渲染标签颜色
	   }   
	});
}

//为标签设置颜色值
function setBgColor(attrStr,id,index){
	if(colorObj[id] == undefined){
		if(colorList[index] == undefined){
			colorList[index] = '#0EA3CA';
		}
		colorObj[id] = colorList[index];
	}
}
//渲染标签颜色
function applyTabColor(){
	//目前只有两种标签属性operid 和 operateid;
	for(var itemId in colorObj){
		$('div[operid="'+itemId+'"]').css('background',$('div[operateid="'+itemId+'"]').attr("bgcolor"));
	}
}

//去除字符串的0
function strZero(str){
	str=str.replace(/\b(0+)/gi,"");
	return str;
}

//url参数中文转编码
function EncodeURI(str){
	str=encodeURI(encodeURI(str));
	return str;
}

//生成格子的位置区间数组
function gridArrOn(){
	gridArr=[];//重置数组
	var gridbox=schTable.find("li"),areaObj={};
	$.each(gridbox,function(i,value) {
		areaObj.X1=$(this).offset().left;
		areaObj.Y1=$(this).offset().top;
		areaObj.X2=areaObj.X1+125;
		areaObj.Y2=areaObj.Y1+125;
		gridArr[i]=areaObj;
		areaObj={};//重置对象
	});	
	
	$("#lucidPop").height($(document).height());
}

//拖曳标签
function dragDrop(){
	$(".external-event").draggable({
		zIndex: 999,
		revert: true,      // will cause the event to go back to its
		revertDuration: 0,  //  original position after the drag
		drag: function (event, ui) { 
			endPosX=event.pageX;
			endPosY=event.pageY;
			for(key in gridArr){
             if(endPosX>gridArr[key].X1&&endPosX<gridArr[key].X2&&endPosY>gridArr[key].Y1&&endPosY<gridArr[key].Y2){
            	 schTable.find("li").removeClass("on").eq(key).addClass("on");
             }
			}
		},
        stop: function () { 
        	schTable.find("li").removeClass("on");
        	var endGridName=$.trim($(this).html()),
				targetUnit=$(this).attr("unit"),
				operId=$(this).attr("operateid"),
				targetBgColor=$(this).attr("bgcolor"),
        		inexistLabel=true;//查询是否格子内已存在该操作标签

        	for(key in gridArr){
	             if(endPosX>gridArr[key].X1&&endPosX<gridArr[key].X2&&endPosY>gridArr[key].Y1&&endPosY<gridArr[key].Y2){ 
	            	 var targetGrid=schTable.find("li").eq(key),
	            	     target_gridLabel=targetGrid.find(".tableLabel");
	            	 
	            	 console.log(target_gridLabel);
	            	 
	            	 if(target_gridLabel.length>0){
		            	 $.each(target_gridLabel,function(i,value) {//查询是否格子内已存在该操作标签
		            		 targetMany=i;
		            		 targetMany++;
		            		 if(endGridName==$.trim($(this).find("span").html())){
		            			 alert("此天已经添加过了这操作，继续其它操作");
		            			 inexistLabel=false;
		            			 return;
		                	 }  
		            	 });	
	            	 }else{
	            		 targetMany=0;
	            	 }

	            	 if(inexistLabel){
	            		 targetGrid.append('<div class="tableLabel" style="background:#'+targetBgColor+'" operId="'+operId+'"><span>'+endGridName+'</span><font></font><i>'+targetUnit+'</i></div>');
	            		 var tbLb_top=targetMany*24-80;//24为标签与上边距之和,-80为距离第一个标签的起始位置
	            		 targetGrid.find(".tbLbNum").attr("style","top:"+tbLb_top+"px").fadeIn(50);
	            		 targetGrid.find(".tbLbNum .numIpt").focus();
	            		 $("#lucidPop").fadeIn(50);
	            		 
						 target_tbLbIndex=targetMany;//确定当前编辑的是格子内的第几个标签
	            	 }
	             }
			}
        	$("#schTable ul li").attr("style","");
        	adapteLi();
        	applyTabColor();
		}
	});
}

//表单高度自适应
function adapteLi(){
	var total=$("#schTable ul li").last().find(".day_number").html(),
		   rows=Math.ceil(total/6),
	       rowsHeight=[],
	       liHeight=maxHeight='';
	for(var i=0;i<rows;i++){
		rowsHeight=[];
		liHeight=maxHeight='';
		for(var k=i*6+1;k<i*6+7;k++){
			liHeight=$("#schTable ul li").eq(k-1).height();
			rowsHeight.push(liHeight);
		}
		maxHeight=_maxHeight(rowsHeight);
		for(var j=i*6+1;j<i*6+7;j++){
			$("#schTable ul li").eq(j-1).height(maxHeight);
		}
	}
	
	gridArrOn();//重新计算格子区间
}

function _maxHeight(array){
	return Math.max.apply(Math,array);  
}
