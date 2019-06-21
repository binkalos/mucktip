<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.img{
	width: 200px; height:200px;
}

a{
	text-decoration: none;
}
.choice-menu-wrapper {
	margin-left: auto;
    margin-right: auto;
    max-width: 1040px;
    width: 100%;
}
.map{
	margin-left: auto;
    margin-right: auto;
    max-width: 1040px;
}
</style>
</head>
<body>
<!-- Top -->
<%@ include file="TopWrapper.jsp"%>

	<div class="choice-menu-wrapper">
	<br>
	<b><p class="choice-information">오늘 뭐 먹지?</p></b>
		<!-- 한식 -->
		<a class="korean" href="korean.jsp">
			<img class="korean-img img" src="img/korea.png">
		</a>
		<!-- 양식 -->
		<a class="western" href="western.jsp">
			<img class="western-img img" src="img/western.png">
		</a>
		<!-- 중식 -->
		<a class="chinese" href="chinese.jsp">
			<img class="chinese-img img" src="img/china.png">
		</a>
		<!-- 일식 -->
		<a class="chinese" href="japanese.jsp">
			<img class="chinese-img img" src="img/japan.png">
		</a>
		<!-- 분식 -->
		<a class="flourfood" href="flourfood.jsp">
			<img class="flourfood-img img" src="img/flour.png"> 
		</a>
	</div><!-- c-m-w -->
	
	<b><p class="map">주변 음식점 찾기</p></b>
	<br>
	<%@ include file="map7.jsp"%>
<%@ include file="footer.jsp"%>
</body>
</html>