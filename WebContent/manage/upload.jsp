<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
   response.setHeader("Pragma", "No-cache");
   response.setHeader("Cache-Control", "no-cache");
   response.setHeader("Expires", "0");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta charset="UTF-8">
  <title>筑田后台管理系统</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <%@ include file="/manage/package.jsp"%>
  
  <style type="text/css">
  body{overflow:hidden;}
</style>
<base target="_self">
</head>

<body>
  <form id="uploadForm" action="${contextPath}/manage/upload"  class="form-horizontal" method="post" enctype="multipart/form-data">
  <input type="hidden" name="id" value="${obj.designerVO.id}">
    <div class="control-group">
      <label class="control-label" for="pic">姓名</label>
      <div class="controls">
        <input type="file" class="btn" name="pic"  size="30"/><input type="submit"  class="btn" value="上传"/>
      </div>
    </div>
  </form>
  
  <script>
  $( function(){
		$('#addMoreFile').click(function() {
			$(this).before('<input name="file" type="file"></input><p/>');
		});
	});
  
    function saveDesigner(){
    	$('#designerForm').ajaxForm(function() { 
            alert("保存成功");
            window.close();
        }); 
    }
  
  </script>
</body>
</html>
