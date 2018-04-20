<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet"
	href="${contextPath}/manage/common/styleForTag.css">
<!--BEGIN TAG-->
<div class="col-md-6">
	<div class="form-group">
		<label for="商品标签" class="col-md-3 control-label">商品标签</label>
		<div class="col-md-9">
			<input name="goodsTag" id="tag" type="hidden" class="form-control"
				value="${obj.goodVO.goodsTag}" />
		</div>
		<div class="col-md-9">
			<button name="btn1" id="btn1" type="button" class="btnx"
				onclick="insertTag(this)" value="新品上架;">新品上架</button>
			<button name="btn2" id="btn2" type="button" class="btnx"
				onclick="insertTag(this)" value="热卖推荐;">热卖推荐</button>
			<button name="btn3" id="btn3" type="button" class="btnx"
				onclick="insertTag(this)" value="清仓优惠;">清仓优惠</button>
		</div>
	</div>
</div>
<!-- <div class="col-md-6">
	                                                    <label for="reachDate" class="col-md-3 control-label"></label>
	                                                    <div class="col-md-5 ">
	                                                    	<button name="btn1" id="btn1" type="button" class="btnx" onclick="insertTag(this)" value="标签01;" >新品上架</button>
	                                                    	<button name="btn2" id="btn2" type="button" class="btnx" onclick="insertTag(this)" value="标签02;" >热卖推荐</button>
	                                                    	<button name="btn3" id="btn3" type="button" class="btnx" onclick="insertTag(this)" value="标签03;" >清仓优惠</button>
	                                                    </div>
	                                                </div> -->
<!--END TAG-->

<script type="text/javascript">

    //在父页面的ready function中加入此方法
    /* $(document).ready(function(){
		var tag = document.getElementById("tag").value;
		for(var n = 1; n <= 10; n++){
			var btn = document.getElementById("btn"+n).value;
    		var index = tag.match(btn); 
			if(index){
    			document.getElementById("btn" + n).className="btnx btnx-default";
    		}
		}
	}); */
    
    function insertTag(obj){
    	var tag = document.getElementById("tag").value;
    	var btn = $(obj).val();
        if(tag.match(btn)){
        	tag = tag.replace(btn,'');
        	$(obj).removeClass('btnx-default'); 
        }else{
        	tag = tag + btn;
        	$(obj).addClass('btnx-default'); 
        }
    	$("#tag").val(tag);
    };
</script>