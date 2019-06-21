<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>데이트 음식을 고르지 못한 사람들에게</title>
</head>
<body>
<div class="question-wrapper">

	<div class="first-question">
		<input type="radio" id="lovemeat" name="meat" value="고기 좋아">고기 좋아
		<input type="radio" id="hatemeat" name="meat" value="고기 싫어">고기 싫어
	</div><!-- first -->
	<% 
		request.setCharacterEncoding("UTF-8");
	%>
	<div class="second-question">
		<input type="radio" name="meat" value="고기 좋아">고기 좋아
		<input type="radio" name="meat" value="고기 싫어">고기 싫어
	</div><!-- second -->
</div><!-- question-wrapper -->
</body>
</html>