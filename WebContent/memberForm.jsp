<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<pre>
*jsp에서 기본으로 제공되는 내장객체는 9개
-request,response,out : 입출력과 관련
-session, application,pageContext : 현재 실행되는 페이지의 외부환경 정보와 관련
-page : jsp페이지 그 자체를 의미
-config:서블릿을 초기화 하는 동안 참조 할 정보를 전해주는 역활
-exception:예외 객체
</pre>
<hr>
<b>내장객체중request,response연습</b>
<br>
<form method="post" action="memberProc.jsp">
	id : <input type="text" name="id" size="10"><br>
	pw : <input type="password" name="pw" size="10"><br>
	name : <input type="text" name="name" size="10"><br>
	job : <select name="job">
			<option value="학생">학생</option>
			<option value="교사">교사</option>
			<option value="기타">기타</option>
		  </select>
		 <input type="submit" value="등록">
		 <input type="reset" value="취소">
</form>
</body>
</html>