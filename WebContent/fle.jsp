<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="js/jquery-3.3.1.min.js"></script>
<script>
	function LoadImg(value){
		if(value.files&&value.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				$('#LoadImg').attr('src',e.target.result);
			}
			reader.readAsDataURL(value.files[0]);
		}
	}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!--print img-->
	<img id = "LoadImg">
	<pre class="brush:html"><input type="file" id="imgAttach" name="imgAttach" onchange="LoadImg(this);">
	
</body>
</html>