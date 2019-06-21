<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css" >
<script src="js/jquery-3.3.1.min.js"></script>
<script>
	function loadImg(value){
		if(value.files&&value.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				$('#LoadImg').attr('src',e.target.result);
			}
			reader.readAsDataURL(value.files[0]);
		}
	}
	
	function postCheck() {
		var form = document.form;
		if(!form.title.value) {
			alert("음식이름을 입력해주세요.");
			form.title.focus();
			return;
		}
		if(!form.image1.value) {
			alert("적어도 1개 이상의 이미지를 삽입해주세요.");
			form.image1.focus();
			return;
		}
		if(!form.content.value) {
			alert("레시피를 입력해주세요.");
			form.content.focus();
			return;
		}
		form.submit();
	}
</script>
</head>
<body>
<center>
<a href="firstPage.jsp"><img src="img/title.png" id="titleimg"></a>
</center>
<section class="page">
<div class="backimg">
	<div class="well">
		<form class="upload" name="form" action="upimg.jsp" method="post" enctype="multipart/form-data">
			<h4>음식 이름</h4>
			<input type="text" class="foodname" name="title" placeholder="음식이름을 적어주세요.">
					
			<div class="picture-wrapper">
				<h4>음식 이미지</h4>
				<img id="LoadImg" width="100" height="100"><br>
				메인 사진 : <input type="file" id="imgAttach1" name="image1" onchange="loadImg(this);" accept=".png, .jpg, .jpeg"><br>
				사진1 : <input type="file" id="imgAttach2" name="image2" onchange="loadImg(this);" accept=".png, .jpg, .jpeg"><br>
				사진2 : <input type="file" id="imgAttach3" name="image3" onchange="loadImg(this);" accept=".png, .jpg, .jpeg"><br>
			</div>
			
			<div class="recipe-wrapper">
				<h4>레시피</h4>
				<textarea class="recipe" name="content" placeholder="레시피를 입력해주세요." rows="8" cols="10"></textarea>
			</div>
			<br>
			<div class="button-wrapper">
				<button class="upbtn" type="button" onclick="postCheck()">
					<img src="img/up.png" class="upimg">
				</button>
			</div>
			
		</form>
	</div>
</div>
</section>





</body>
</html>